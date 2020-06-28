require "rails_helper"

describe Lib::BaseEvent do
  TEST_AGGREGATE_TABLE_NAME = :temporary_test_aggregate
  TEST_EVENT_TABLE_NAME = :temporary_test_event

  module BaseEventTest
    class Aggregate < ApplicationRecord
      self.table_name = TEST_AGGREGATE_TABLE_NAME.to_s
    end

    # Event classes must look like this
    class Event < Lib::BaseEvent
      self.table_name = TEST_EVENT_TABLE_NAME.to_s

      data_attributes :foo, :bar

      belongs_to(
        :test_aggregate,
        class_name: "::BaseEventTest::Aggregate",
        autosave: false
      )

      def apply(aggregate)
        aggregate.description = "I was modified via #apply"
        aggregate
      end
    end
  end

  before(:all) do
    # Not completely in love with this solution but it works and is
    # fast enough.
    m = ActiveRecord::Migration.new
    m.verbose = false

    m.create_table TEST_EVENT_TABLE_NAME do |t|
      # Every event table must have these two columns.
      t.text :data, null: false
      t.text :metadata, null: false

      # Add the required column for the belongs to association with
      # the aggregator model.
      t.integer :test_aggregate_id, null: false

      # t.string :type, null: false
      # t.datetime :created_at, null: false
    end

    # Creates the aggregate table to prevent "undefined table" error
    # when ActiveRecord tries to relate both models.
    m.create_table TEST_AGGREGATE_TABLE_NAME do |t|
      # Used during the #apply tests
      t.string :description, null: true
    end
  end

  after(:all) do
    m = ActiveRecord::Migration.new
    m.verbose = false

    m.drop_table TEST_EVENT_TABLE_NAME
    m.drop_table TEST_AGGREGATE_TABLE_NAME
  end

  context "before_validation" do
    subject { BaseEventTest::Event.new }

    it "builds the aggregate" do
      expect(subject.aggregate).to be_nil

      subject.valid?

      expect(subject.aggregate).to be_a(BaseEventTest::Aggregate)
    end
  end

  context "after_initialize" do
    subject { BaseEventTest::Event.new }

    it "sets data attribute with an empty hash" do
      expect(subject.data).to eq({})
    end

    it "sets metadata attribute with an empty hash" do
      expect(subject.metadata).to eq({})
    end
  end

  context "before_create" do
    let!(:aggregate) { BaseEventTest::Aggregate.create! }

    # NOTE: This test is almost the same of #apply method. We might
    #       want to get rid of the #apply one and just keep this one.
    it "applies and persists the changes to the aggregate" do
      expect {
        BaseEventTest::Event.create!(test_aggregate: aggregate)
      }.to change { aggregate.reload.description }.from(nil).to("I was modified via #apply")
    end

    # NOTE: Revisit the need of this test. It seems to be testing the
    #       tool under the hood.
    it "creates a new event" do
      expect {
        BaseEventTest::Event.create!(test_aggregate: aggregate)
      }.to change { BaseEventTest::Event.count }.by(1)
    end

    it "locks the aggregate before save" do
      # Assertions on the order of method calls are not recommend,
      # however, here we must ensure it does a pessimist lock before
      # persist the data.
      allow(aggregate).to receive(:lock!).and_call_original
      allow(aggregate).to receive(:save!).and_call_original

      BaseEventTest::Event.create!(test_aggregate: aggregate)

      expect(aggregate).to have_received(:lock!).once.ordered
      expect(aggregate).to have_received(:save!).once.ordered
    end
  end

  context "after_create" do
    let!(:aggregate) { BaseEventTest::Aggregate.create! }

    it "dispatches the event" do
      allow(Events::Dispatcher).to receive(:dispatch).and_return(true)

      event = BaseEventTest::Event.create!(test_aggregate: aggregate)

      expect(Events::Dispatcher).to have_received(:dispatch).with(event).once
    end
  end

  context "serialization" do
    subject { BaseEventTest::Event.new }

    # TODO: Serialization can be done with many types, so we must
    #       ensure that here it's with JSON. However, using the
    #       `.as(JSON)` doesn't work.
    it { is_expected.to serialize(:data) }
    it { is_expected.to serialize(:metadata) }
  end

  describe ".data_attributes" do
    subject { BaseEventTest::Event.new(data: { foo: "foo", bar: "bar" }) }

    it "generates getters" do
      is_expected.to have_attributes(foo: "foo", bar: "bar")
    end

    it "generates setters" do
      subject.foo = "bar"
      subject.bar = "foo"

      expect(subject.foo).to eq("bar")
      expect(subject.bar).to eq("foo")
    end
  end

  describe ".aggregate_name" do
    it "returns the first belongs_to association name" do
      expect(BaseEventTest::Event.aggregate_name).to eq(:test_aggregate)
    end

    context "when aggregate belongs_to association is not defined" do
      class BaseEventTest::EventWithoutAggregate < Lib::BaseEvent
        # Ruses the same table, we just want to bypass ActiveRecord
        # schema reflections.
        self.table_name = TEST_EVENT_TABLE_NAME
      end

      it "raises an exception" do
        expect {
          BaseEventTest::EventWithoutAggregate.aggregate_name
        }.to raise_error("Events must belong to an aggregate")
      end
    end
  end

  describe "#apply" do
    let!(:aggregate) { BaseEventTest::Aggregate.new }

    subject { BaseEventTest::Event.new }

    it "applies changes and return the aggregate" do
      expect {
        subject.apply(aggregate)
      }.to change { aggregate.description }.from(nil).to("I was modified via #apply")
    end

    it "does not persist data" do
      expect {
        subject.apply(aggregate)
      }.to_not change { BaseEventTest::Aggregate.count }
    end

    context "when not implemented" do
      class BaseEventTest::EventWithApplyNotImplemented < Lib::BaseEvent
        # Ruses the same table, we just want to bypass ActiveRecord
        # schema reflections.
        self.table_name = TEST_EVENT_TABLE_NAME.to_s
      end

      subject { BaseEventTest::EventWithApplyNotImplemented.new }

      it "raises an NotImplementedError" do
        expect {
          subject.apply(aggregate)
        }.to raise_error(NotImplementedError)
      end
    end
  end

  describe "#aggregate=" do
    subject { BaseEventTest::Event.new }

    it "sets the aggregate" do
      expected_aggregate = BaseEventTest::Aggregate.new

      expect {
        subject.aggregate = expected_aggregate
      }.to change { subject.aggregate }.from(nil).to(expected_aggregate)
    end
  end

  describe "#aggregate_id=" do
    subject { BaseEventTest::Event.new }

    it "sets the aggregate_id" do
      expect {
        subject.aggregate_id = 99
      }.to change { subject.aggregate_id }.from(nil).to(99)
    end
  end

  describe "#aggregate_foreign_key" do
    subject { BaseEventTest::Event.new }

    it "composes from the belongs_to association name" do
      expect(subject.aggregate_foreign_key).to eq("test_aggregate_id")
    end

    context "when belongs_to foreign_key option is set" do
      class BaseEventTest::EventWithAggregateForeignKeySet < Lib::BaseEvent
        # Ruses the same table, we just want to bypass ActiveRecord
        # schema reflections.
        self.table_name = TEST_EVENT_TABLE_NAME.to_s

        belongs_to(
          :test_aggregate,
          foreign_key: "foo_id",
          class_name: "::BaseEventTest::Aggregate",
          autosave: false
        )
      end

      subject { BaseEventTest::EventWithAggregateForeignKeySet.new }

      it "returns the foreign_key" do
        expect(subject.aggregate_foreign_key).to eq("foo_id")
      end
    end
  end
end

require "rails_helper"

describe EventSource::Command do
  context "mixin" do
    it "extends ActiveSupport::Concern" do
      expect(EventSource::Command).to be_a_kind_of(ActiveSupport::Concern)
    end
  end

  module TestCommand
    class Command
      include EventSource::Command

      # In order to avoid create a test event which would require a fake
      # migration alongside of it we need a double. However, RSpec have
      # some limitations on where you can create a double, so in order
      # to workaround them we inject it as a command attribute.
      #
      # Just keep in mind, `event_double` is not part of the command
      # itself nor is necessary in a normal scenario - it's just a test
      # thing.
      attributes :foo, :event_double

      validates_presence_of :foo

      def build_event
        event_double
      end
    end
  end

  def build_event_double
    double(
      EventSource::BaseEvent,
      :persisted? => false,
      :save! => true
    )
  end

  subject do
    TestCommand::Command.new(
      event_double: build_event_double(),
      foo: "foo"
    )
  end

  it { is_expected.to be_a_kind_of(ActiveModel::Validations) }

  describe "#call" do
    it "saves the event" do
      subject.call()

      expect(subject.event_double).to have_received(:save!).once
    end

    it "returns the event" do
      expect(subject.call()).to eq(subject.event_double)
    end

    context "when event is persisted" do
      it "raises an error" do
        expect {
          TestCommand::Command.new(
            event_double: double(EventSource::BaseEvent, :persisted? => true),
            foo: "foo"
          ).call()
        }.to raise_error("The event should not be persisted at this stage!")
      end
    end

    context "when event is nil" do
      class TestCommand::CommandWithoutEvent
        include EventSource::Command

        def build_event
          nil
        end
      end

      it "returns nil" do
        expect(TestCommand::CommandWithoutEvent.new().call).to eq(nil)
      end
    end

    context "when event is invalid" do
      # Sets `foo` attribute to empty so presence validation fails.
      subject do
        TestCommand::Command.new(
          event_double: build_event_double(),
          foo: ""
        )
      end

      # TODO: This is a dangerous test because the default behaviour
      #       of an empty test in RSpec is to pass, so if `call`
      #       doesn't raise the assertion would never happen.
      it "does not save the event" do
        begin
          subject.call()
        rescue
          expect(subject.event_double).to_not have_received(:save!)
        end
      end

      it "raises ActiveModel::ValidationError" do
        expect {
          subject.call()
        }.to raise_error(ActiveModel::ValidationError)
      end
    end
  end
end

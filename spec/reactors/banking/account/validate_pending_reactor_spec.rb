require "rails_helper"

describe Banking::Account::ValidatePendingReactor do
  include EventSource::TestHelper

  before(:each) { prevent_event_dispatch }

  subject do
    described_class.call(
      Events::Banking::Account::Created.new(
        account: build(:account, :pending)
      )
    )
  end

  describe ".call" do
    it "creates account status updated event" do
      expect { subject }.to change {
        Events::Banking::Account::StatusUpdated.count
      }.by(1)
    end

    it "sets event status to opened" do
      subject
      event = Events::Banking::Account::StatusUpdated.last

      expect(event.data["status"]).to eq(Banking::Account::OPENED)
    end

    it "sets reactor name as the event source" do
      subject
      event = Events::Banking::Account::StatusUpdated.last

      expect(event.metadata["source"]).to eq(described_class.to_s)
    end
  end
end

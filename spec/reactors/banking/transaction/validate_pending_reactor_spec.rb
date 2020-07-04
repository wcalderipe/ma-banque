require "rails_helper"

describe Banking::Transaction::ValidatePendingReactor, focus: true do
  include EventSource::TestHelper

  before(:each) { prevent_event_dispatch }

  subject do
    tx = build(
      :transaction, :credit, :pending,
      account: build(:account, :opened)
    )

    described_class.call(
      Events::Banking::Transaction::Created.new(tx: tx)
    )
  end

  describe ".call" do
    it "creates transaction status updated event" do
      expect { subject }.to change {
        Events::Banking::Transaction::StatusUpdated.count
      }.by(1)
    end

    it "sets event status to approved" do
      subject
      event = Events::Banking::Transaction::StatusUpdated.last

      expect(event.data["status"]).to eq(Banking::Transaction::APPROVED)
    end

    it "sets reactor name as the event source" do
      subject
      event = Events::Banking::Transaction::StatusUpdated.last

      expect(event.metadata["source"]).to eq(described_class.to_s)
    end
  end
end

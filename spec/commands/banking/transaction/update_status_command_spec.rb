require "rails_helper"

describe Banking::Transaction::UpdateStatusCommand do
  include EventSource::TestHelper

  before(:each) { prevent_event_dispatch }

  let(:tx) do
    create(
      :transaction, :credit, :pending,
      # TODO: This is fundamentally wrong. Why the transaction doesn't
      # need the account to be created upfront?
      # Any transaction must belong to an existing account with any
      # status except pending.
      account: build(:account, :opened)
    )
  end

  subject do
    described_class.call(
      tx: tx,
      status: Banking::Transaction::APPROVED,
      metadata: { source: "test" }
    )
  end

  it "updates aggregator status" do
    expect { subject }.to change {
      tx.reload.status
    }.to(Banking::Transaction::APPROVED)
  end

  context "when status is the same" do
    subject do
      described_class.call(
        tx: tx,
        status: Banking::Transaction::PENDING,
        metadata: { source: "test" }
      )
    end

    it "does not create an event" do
      expect { subject }.to change {
        Events::Banking::Transaction::StatusUpdated.count
      }.by(0)
    end
  end
end

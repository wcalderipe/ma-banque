require "rails_helper"

describe Commands::Transaction::UpdateStatus do
  let(:tx) { Transaction.create!(status: Transaction::PENDING) }

  subject do
    described_class.call(
      tx: tx,
      status: Transaction::APPROVED,
      metadata: { source: "test" }
    )
  end

  it "updates the aggregator status" do
    expect {
      subject
    }.to change { tx.reload.status }.to(Transaction::APPROVED)
  end

  context "when status is the same" do
    subject do
      described_class.call(
        tx: tx,
        status: Transaction::PENDING,
        metadata: { source: "test" }
      )
    end

    it "does not create a new event" do
      expect {
        subject
      }.to change { Events::Transaction::StatusUpdated.count }.by(0)
    end
  end
end

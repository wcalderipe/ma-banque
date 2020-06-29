require "rails_helper"

describe Transaction::ValidatePendingReactor do
  subject { described_class.call(metadata: { source: "test" }) }

  let(:tx) do
    Transaction.create!(
      kind: Transaction::CREDIT,
      balance: 99,
      status: Transaction::PENDING
    )
  end

  describe ".call" do
    it "sets transaction status to approved" do
      expect {
        Events::Transaction::Created.create!(tx: tx)
      }.to change { tx.status }.to(Transaction::APPROVED)
    end

    it "sets the class name in the metadata source" do
      Events::Transaction::Created.create!(tx: tx)
      event = Events::Transaction::StatusUpdated.last

      expect(event.metadata["source"]).to eq("Transaction::ValidatePendingReactor")
    end
  end
end

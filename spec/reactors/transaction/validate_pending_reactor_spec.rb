require "rails_helper"

describe Transaction::ValidatePendingReactor do
  let(:account) { create(:account, :opened) }

  describe ".call" do
    it "sets transaction status to approved" do
      Events::Transaction::Created.create!(
        account: account,
        kind: Transaction::CREDIT,
        balance: 0
      )

      expect(Transaction.last.status).to eq(Transaction::APPROVED)
    end

    it "sets the class name in the metadata source" do
      Events::Transaction::Created.create!(
        account: account,
        kind: Transaction::CREDIT,
        balance: 0
      )
      last_status_updated = Events::Transaction::StatusUpdated.last

      expect(last_status_updated.metadata["source"]).to eq("Transaction::ValidatePendingReactor")
    end
  end
end

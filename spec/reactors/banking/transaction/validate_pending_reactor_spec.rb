require "rails_helper"

describe Banking::Transaction::ValidatePendingReactor do
  let(:account) { create(:account, :opened) }

  describe ".call" do
    it "sets transaction status to approved" do
      Events::Banking::Transaction::Created.create!(
        account: account,
        kind: Banking::Transaction::CREDIT,
        balance: 0
      )

      expect(Banking::Transaction.last.status).to eq(Banking::Transaction::APPROVED)
    end

    it "sets the class name in the metadata source" do
      Events::Banking::Transaction::Created.create!(
        account: account,
        kind: Banking::Transaction::CREDIT,
        balance: 0
      )
      last_status_updated = Events::Banking::Transaction::StatusUpdated.last

      expect(last_status_updated.metadata["source"]).to eq(described_class.to_s)
    end
  end
end

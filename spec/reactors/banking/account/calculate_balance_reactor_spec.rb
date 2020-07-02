require "rails_helper"

describe Banking::Account::CalculateBalanceReactor do
  let(:account) { create(:account, :opened) }

  let(:tx) do
    create(
      :transaction, :credit, :pending,
      account: account,
      balance: 99
    )
  end

  describe ".call" do
    it "sets account status to opened" do
      expect {
        Events::Banking::Transaction::StatusUpdated.create!(
          tx: tx,
          status: Banking::Transaction::APPROVED
        )
      }.to change { account.reload.balance }.to(99)
    end

    it "sets event source to the class name" do
      Events::Banking::Transaction::StatusUpdated.create!(
        tx: tx,
        status: Banking::Transaction::APPROVED
      )
      last_event = Events::Banking::Account::BalanceUpdated.last

      expect(last_event.metadata["source"]).to eq(described_class.to_s)
    end
  end
end

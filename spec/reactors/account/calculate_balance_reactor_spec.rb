require "rails_helper"

describe Account::CalculateBalanceReactor do
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
        Events::Transaction::StatusUpdated.create!(
          tx: tx,
          status: Transaction::APPROVED
        )
      }.to change { account.reload.balance }.to(99)
    end

    it "sets event source to the class name" do
      Events::Transaction::StatusUpdated.create!(
        tx: tx,
        status: Transaction::APPROVED
      )
      last_event = Events::Account::BalanceUpdated.last

      expect(last_event.metadata["source"]).to eq("Account::CalculateBalanceReactor")
    end
  end
end

require "rails_helper"

describe Banking::Account::UpdateBalanceCommand do
  let(:account) do
    create(:account, :opened, balance: 50)
  end

  let(:tx) do
    build(
      :transaction, :approved, :credit,
      account: account,
      balance: 100
    )
  end

  subject do
    described_class.call(
      tx: tx,
      metadata: { source: "test" }
    )
  end

  context "when credit transaction" do
    it "credits the balance" do
      expect {
        subject
      }.to change { account.reload.balance }.to(150)
    end
  end

  context "when debit transaction" do
    let(:tx) do
      create(
        :transaction, :approved, :debit,
        account: account,
        balance: 50
      )
    end

    it "debits the balance" do
      expect {
        subject
      }.to change { account.reload.balance }.to(0)
    end
  end
end

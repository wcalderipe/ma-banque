require "rails_helper"

describe Account::UpdateBalanceCommand do
  let(:account) { Account.create!(status: Account::OPENED, balance: 0) }
  let(:tx) do
    Transaction.create!(
      status: Transaction::APPROVED,
      kind: Transaction::CREDIT,
      balance: 100
    )
  end

  subject do
    described_class.call(
      account: account,
      tx: tx,
      metadata: { source: "test" }
    )
  end

  it "updates the aggregator balance" do
    expect {
      subject
    }.to change { account.reload.balance }.to(100)
  end
end

require "rails_helper"

describe Banking::Account::UpdateBalanceCommand do
  let(:account) { create(:account, :opened) }

  let(:tx) do
    create(
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

  it "updates the aggregator balance" do
    expect {
      subject
    }.to change { account.reload.balance }.to(100)
  end
end

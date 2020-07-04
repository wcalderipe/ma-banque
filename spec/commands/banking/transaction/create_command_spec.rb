require "rails_helper"

describe Banking::Transaction::CreateCommand do
  include EventSource::TestHelper

  before(:each) { prevent_event_dispatch }

  let(:account) { build(:account, :opened) }

  subject do
    described_class.call(
      account: account,
      kind: Banking::Transaction::CREDIT,
      balance: 99,
      metadata: { source: "test" }
    )
  end

  it "creates an event" do
    expect { subject }.to change {
      Events::Banking::Transaction::Created.count
    }.by(1)
  end

  it "creates a transaction" do
    expect { subject }.to change {
      Banking::Transaction.count
    }.by(1)
  end

  it "sets transaction status to pending" do
    subject
    last_tx = Banking::Transaction.last

    expect(last_tx.status).to eq(Banking::Transaction::PENDING)
  end

  it "sets transaction kind to credit" do
    subject
    last_tx = Banking::Transaction.last

    expect(last_tx.kind).to eq(Banking::Transaction::CREDIT)
  end
end

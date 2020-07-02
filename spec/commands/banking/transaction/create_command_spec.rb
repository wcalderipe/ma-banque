require "rails_helper"

describe Banking::Transaction::CreateCommand do
  let(:account) { create(:account, :opened) }

  subject do
    described_class.call(
      account: account,
      kind: Banking::Transaction::CREDIT,
      balance: 99,
      metadata: { source: "test" }
    )
  end

  it "creates an event with metadata" do
    expect {
      described_class.call(
        account: account,
        kind: Banking::Transaction::CREDIT,
        balance: 99,
        metadata: { source: "test" }
      )
    }.to change { Events::Banking::Transaction::Created.count }.by(1)

    last_tx_created = Events::Banking::Transaction::Created.last

    expect(last_tx_created.metadata).to eq({ "source" => "test" })
  end

  it "creates a pending transaction" do
    expect {
      described_class.call(
        account: account,
        kind: Banking::Transaction::CREDIT,
        balance: 99,
        metadata: { source: "test" }
      )
    }.to change { Banking::Transaction.count }.by(1)

    last_tx = Banking::Transaction.last

    expect(last_tx.kind).to eq(Banking::Transaction::CREDIT)
    expect(last_tx.balance).to eq(99)
  end

  it "triggers validate pending reactor" do
    expect {
      subject
    }.to change { Events::Banking::Transaction::BaseEvent.count }.by(2)

    last_event = Events::Banking::Transaction::BaseEvent.last

    expect(last_event).to be_a(Events::Banking::Transaction::StatusUpdated)
  end
end

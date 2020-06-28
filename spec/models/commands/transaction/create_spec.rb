require "rails_helper"

describe Commands::Transaction::Create do
  subject do
    described_class.call(
      kind: Transaction::CREDIT,
      balance: 99,
      metadata: { source: "test" }
    )
  end

  it "creates an event with metadata" do
    expect {
      described_class.call(
        kind: Transaction::CREDIT,
        balance: 99,
        metadata: { source: "test" }
      )
    }.to change { Events::Transaction::Created.count }.by(1)

    last_tx_created = Events::Transaction::Created.last

    expect(last_tx_created.metadata).to eq({ "source" => "test" })
  end

  it "creates a pending transaction" do
    expect {
      described_class.call(
        kind: Transaction::CREDIT,
        balance: 99,
        metadata: { source: "test" }
      )
    }.to change { Transaction.count }.by(1)

    last_tx = Transaction.last

    expect(last_tx.kind).to eq(Transaction::CREDIT)
    expect(last_tx.balance).to eq(99)
  end

  it "triggers validate pending reactor" do
    expect {
      subject
    }.to change { Events::Transaction::BaseEvent.count }.by(2)

    last_event = Events::Transaction::BaseEvent.last

    expect(last_event).to be_a(Events::Transaction::StatusUpdated)
  end
end

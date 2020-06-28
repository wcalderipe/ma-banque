require "rails_helper"

describe Commands::Account::Create do
  subject { described_class.call(metadata: { source: "test" }) }

  it "creates an event with metadata" do
    expect {
      subject
    }.to change { Events::Account::Created.count }.by(1)

    last_account_created = Events::Account::Created.last

    expect(last_account_created.metadata).to eq({ "source" => "test" })
  end

  it "creates an account" do
    expect { subject }.to change { Account.count }.by(1)
  end

  it "triggers account validator reactor after create" do
    expect {
      subject
    }.to change { Events::Account::BaseEvent.count }.by(2)

    last_event = Events::Account::BaseEvent.last

    expect(last_event).to be_a(Events::Account::StatusUpdated)
  end
end

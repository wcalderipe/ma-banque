require "rails_helper"

describe Commands::Account::Create do
  it "creates an account" do
    expect {
      Commands::Account::Create.call(metadata: { source: "test" })
    }.to change { Account.count }.by(1)
  end
end

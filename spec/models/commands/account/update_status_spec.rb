require "rails_helper"

describe Commands::Account::UpdateStatus do
  it "updates the status" do
    account = Account.create(status: Account::PENDING)

    expect {
      Commands::Account::UpdateStatus.call(
        account: account,
        status: Account::OPENED,
        metadata: { source: "test" }
      )
    }.to change { account.reload.status }.to(Account::OPENED)
  end

  context "when status is the same" do
    it "does not create a new event" do
      account = Account.create(status: Account::PENDING)

      expect {
        Commands::Account::UpdateStatus.call(
          account: account,
          status: Account::PENDING,
          metadata: { source: "test" }
        )
      }.to change { Events::Account::StatusUpdated.count }.by(0)
    end
  end
end

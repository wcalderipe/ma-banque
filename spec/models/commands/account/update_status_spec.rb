require "rails_helper"

describe Commands::Account::UpdateStatus do
  it "updates the status" do
    # TODO: Getting a valid enum from the hash is so verbose that
    #       need two variables to improve readability. Explore
    #       something like Account::OPEN.
    pending = Account.statuses.fetch(:pending)
    opened = Account.statuses.fetch(:opened)
    account = Account.create(status: pending)

    expect {
      Commands::Account::UpdateStatus.call(
        account: account,
        status: opened,
        metadata: { source: "test" }
      )
    }.to change { account.reload.status }.to(opened)
  end

  context "when status is the same" do
    it "does not create a new event" do
      pending = Account.statuses.fetch(:pending)
      account = Account.create(status: pending)

      expect {
        Commands::Account::UpdateStatus.call(
          account: account,
          status: pending,
          metadata: { source: "test" }
        )
      }.to change { Events::Account::StatusUpdated.count }.by(0)
    end
  end
end

require "rails_helper"

describe Commands::Account::UpdateStatus do
  let(:account) { Account.create!(status: Account::PENDING) }

  subject do
    Commands::Account::UpdateStatus.call(
      account: account,
      status: Account::OPENED,
      metadata: { source: "test" }
    )
  end

  it "updates the aggregator status" do
    expect {
      subject
    }.to change { account.reload.status }.to(Account::OPENED)
  end

  context "when status is the same" do
    subject do
      Commands::Account::UpdateStatus.call(
        account: account,
        status: Account::PENDING,
        metadata: { source: "test" }
      )
    end

    it "does not create a new event" do
      expect {
        subject
      }.to change { Events::Account::StatusUpdated.count }.by(0)
    end
  end
end

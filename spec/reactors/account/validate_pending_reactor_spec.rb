require "rails_helper"

describe Account::ValidatePendingReactor do
  let(:account) { Account.create!(status: Account::PENDING) }

  describe ".call" do
    it "sets account status to opened" do
      expect {
        Events::Account::Created.create!(account: account)
      }.to change { account.status }.to(Account::OPENED)
    end

    it "sets event source to the class name" do
      Events::Account::Created.create!(account: account)
      event = Events::Account::StatusUpdated.last

      expect(event.metadata["source"]).to eq("Account::ValidatePendingReactor")
    end
  end
end

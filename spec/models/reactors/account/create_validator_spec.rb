require "rails_helper"

RSpec.describe Reactors::Account::CreateValidator do
  describe ".call" do
    it "sets account status to opened" do
      account = Account.create!(status: Account.statuses.fetch(:pending))

      expect {
        Events::Account::Created.create!(account: account)
      }.to change { account.status }.to(Account.statuses.fetch(:opened))
    end

    it "sets event source to the class name" do
      account = Account.create!

      Events::Account::Created.create!(account: account)

      event = Events::Account::StatusUpdated.last

      expect(event.metadata["source"]).to eq("Reactors::Account::CreateValidator")
    end
  end
end

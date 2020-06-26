require "rails_helper"

describe Events::Account::Created do
  describe "#apply" do
    it "sets account status to pending" do
      account = Account.new(status: nil)

      subject.apply(account)

      expect(account.status).to eq(Account.statuses.fetch(:pending))
    end
  end
end

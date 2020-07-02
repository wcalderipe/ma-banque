require "rails_helper"

describe Events::Banking::Account::Created do
  describe "#apply" do
    it "sets account status to pending" do
      account = Banking::Account.new(status: nil)

      subject.apply(account)

      expect(account.status).to eq(Banking::Account::PENDING)
    end
  end
end

require "rails_helper"

describe Events::Banking::Account::Created do
  describe "#apply" do
    it "sets status to pending" do
      account = Banking::Account.new(status: nil)

      subject.apply(account)

      expect(account.status).to eq(Banking::Account::PENDING)
    end

    it "sets balance to zero" do
      account = Banking::Account.new(balance: nil)

      subject.apply(account)

      expect(account.balance).to eq(0)
    end
  end
end

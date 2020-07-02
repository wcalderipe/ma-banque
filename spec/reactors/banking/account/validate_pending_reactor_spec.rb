require "rails_helper"

describe Banking::Account::ValidatePendingReactor do
  let(:account) { create(:account, :pending) }

  describe ".call" do
    it "sets account status to opened" do
      expect {
        Events::Banking::Account::Created.create!(account: account)
      }.to change { account.status }.to(Banking::Account::OPENED)
    end

    it "sets event source to the class name" do
      Events::Banking::Account::Created.create!(account: account)
      event = Events::Banking::Account::StatusUpdated.last

      expect(event.metadata["source"]).to eq(described_class.to_s)
    end
  end
end

require "rails_helper"

describe Banking::Account::UpdateStatusCommand do
  let(:account) { create(:account, :pending) }

  subject do
    described_class.call(
      account: account,
      status: Banking::Account::OPENED,
      metadata: { source: "test" }
    )
  end

  it "updates the aggregator status" do
    expect {
      subject
    }.to change { account.reload.status }.to(Banking::Account::OPENED)
  end

  context "when status is the same" do
    subject do
      described_class.call(
        account: account,
        status: Banking::Account::PENDING,
        metadata: { source: "test" }
      )
    end

    it "does not create a new event" do
      expect {
        subject
      }.to change { Events::Banking::Account::StatusUpdated.count }.by(0)
    end
  end
end

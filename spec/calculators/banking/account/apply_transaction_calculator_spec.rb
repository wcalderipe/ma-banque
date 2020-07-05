require "rails_helper"

describe Banking::Account::ApplyTransactionCalculator do
  include EventSource::TestHelper

  before(:each) { prevent_event_dispatch }

  let(:tx) do
    build(
      :transaction, :credit, :approved,
      account: build(:account, :opened)
    )
  end

  subject do
    described_class.call(
      Events::Banking::Transaction::StatusUpdated.new(
        tx: tx,
        status: Banking::Transaction::APPROVED
      )
    )
  end

  describe ".call" do
    describe "account balance" do
      it "creates an event" do
        expect { subject }.to change {
          Events::Banking::Account::BalanceUpdated.count
        }.by(1)
      end

      it "sets calculator name as the event source" do
        subject
        event = Events::Banking::Account::BalanceUpdated.last

        expect(event.metadata["source"]).to eq(described_class.to_s)
      end
    end

    describe "transaction status" do
      it "creates an event" do
        expect { subject }.to change {
          Events::Banking::Transaction::StatusUpdated.count
        }.by(1)
      end

      it "sets event status to applied" do
        subject
        event = Events::Banking::Transaction::StatusUpdated.last

        expect(event.data["status"]).to eq(Banking::Transaction::APPLIED)
      end

      it "sets calculator name as the event source" do
        subject
        event = Events::Banking::Transaction::StatusUpdated.last

        expect(event.metadata["source"]).to eq(described_class.to_s)
      end
    end

    context "when transaction is not approved" do
      let(:tx) do
        build(
          :transaction, :credit, :pending,
          account: build(:account, :opened)
        )
      end

      it "does not create account balance updated event" do
        expect { subject }.to change {
          Events::Banking::Account::BalanceUpdated.count
        }.by(0)
      end

      it "does not create transaction status updated event" do
        expect { subject }.to change {
          Events::Banking::Transaction::StatusUpdated.count
        }.by(0)
      end
    end
  end
end

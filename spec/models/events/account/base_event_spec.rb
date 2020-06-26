require "rails_helper"

describe Events::Account::BaseEvent do
  describe ".table_name" do
    it do
      expect(Events::Account::BaseEvent.table_name).to eq("account_events")
    end
  end
end

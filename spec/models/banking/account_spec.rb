require "rails_helper"

describe Banking::Account, type: :model do
  describe "attributes" do
    it { is_expected.to respond_to(:id) }

    context "defaults" do
      it do
        is_expected.to have_attributes(
                         balance: 0,
                         status: Banking::Account::PENDING
                       )
      end
    end
  end

  describe "enums" do
    it do
      is_expected.to define_enum_for(:status).with_values(
                       pending: "pending",
                       opened: "opened"
                     ).backed_by_column_of_type(:string)
    end
  end
end

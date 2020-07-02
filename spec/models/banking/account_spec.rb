require "rails_helper"

describe Banking::Account, type: :model do
  describe "attributes" do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:balance) }
    it { is_expected.to have_attributes(status: "pending") }
  end

  describe "enums" do
    it {
      is_expected.to define_enum_for(:status).with_values(
                       pending: "pending",
                       opened: "opened"
                     ).backed_by_column_of_type(:string)
    }
  end
end

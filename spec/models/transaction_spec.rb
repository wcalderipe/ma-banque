require "rails_helper"

describe Transaction, type: :model do
  describe "attributes" do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:status) }
    it { is_expected.to respond_to(:type) }
    it { is_expected.to respond_to(:balance) }
  end

  describe "enums" do
    it {
      is_expected.to define_enum_for(:status).with_values(
                       pending: "pending",
                       approved: "approved",
                       applied: "applied"
                     ).backed_by_column_of_type(:string)
    }
  end
end

require "rails_helper"

describe Banking::Transaction, type: :model do
  describe "attributes" do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:kind) }

    context "defaults" do
      it {
        is_expected.to have_attributes(
                         amount: 0,
                         status: Banking::Transaction::PENDING
                       )
      }
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:account) }
  end

  describe "enums" do
    it do
      is_expected.to define_enum_for(:status).with_values(
                       pending: "pending",
                       approved: "approved",
                       applied: "applied"
                     ).backed_by_column_of_type(:string)
    end

    it do
      is_expected.to define_enum_for(:kind).with_values(
                       credit: "credit",
                       debit: "debit"
                     ).backed_by_column_of_type(:string)
    end
  end
end

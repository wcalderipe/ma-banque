class Transaction < ApplicationRecord
  attribute :status, :string
  attribute :type, :string
  attribute :balance, :decimal

  enum status: {
         pending: PENDING = "pending",
         approved: APPROVED = "approved",
         applied: APPLIED = "applied"
       }

  enum type: {
         credit: CREDIT = "credit",
         debit: DEBIT = "debit"
       }
end

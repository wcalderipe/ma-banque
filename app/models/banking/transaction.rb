class Banking::Transaction < ApplicationRecord
  attribute :status, :string
  attribute :kind, :string
  attribute :amount, :decimal

  belongs_to :account

  enum status: {
         pending: PENDING = "pending",
         approved: APPROVED = "approved",
         applied: APPLIED = "applied",
       }

  enum kind: {
         credit: CREDIT = "credit",
         debit: DEBIT = "debit"
       }
end

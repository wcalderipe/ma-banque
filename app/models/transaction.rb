class Transaction < ApplicationRecord
  attribute :status, :string
  attribute :kind, :string
  attribute :balance, :decimal

  enum status: {
         pending: PENDING = "pending",
         approved: APPROVED = "approved"
       }

  enum kind: {
         credit: CREDIT = "credit",
         debit: DEBIT = "debit"
       }
end

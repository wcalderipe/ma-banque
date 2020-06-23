class Account < ApplicationRecord
  enum status: {
         pending: "pending",
         opened: "opened"
       }
end

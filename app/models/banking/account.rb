class Banking::Account < ApplicationRecord
  enum status: {
         pending: PENDING = "pending",
         opened: OPENED = "opened"
       }
end

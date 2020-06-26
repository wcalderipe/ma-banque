class Events::Account::BaseEvent < Lib::BaseEvent
  self.table_name = "account_events"

  belongs_to :account, autosave: false
end

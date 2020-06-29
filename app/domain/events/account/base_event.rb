class Events::Account::BaseEvent < EventSource::BaseEvent
  self.table_name = "account_events"

  belongs_to :account, class_name: "::Account", autosave: false
end

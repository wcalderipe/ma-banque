class Events::Banking::Account::BaseEvent < EventSource::BaseEvent
  self.table_name = "account_events"

  belongs_to :account, class_name: "::Banking::Account", autosave: false
end

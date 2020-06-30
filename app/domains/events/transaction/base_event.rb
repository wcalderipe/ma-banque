class Events::Transaction::BaseEvent < EventSource::BaseEvent
  self.table_name = "transaction_events"

  # Uses a transaction abbreviation because it was conflicting with a
  # method name from Active Record.
  belongs_to(
    :tx,
    foreign_key: :transaction_id,
    class_name: "::Transaction",
    autosave: false
  )
end

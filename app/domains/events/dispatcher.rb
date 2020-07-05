# Subscribes Reactors to Events.
class Events::Dispatcher < EventSource::EventDispatcher
  on(
    Events::Banking::Account::Created,
    trigger: Banking::Account::ValidatePendingCalculator
  )

  on(
    Events::Banking::Transaction::Created,
    trigger: Banking::Transaction::ValidatePendingCalculator
  )
  on(
    Events::Banking::Transaction::StatusUpdated,
    trigger: Banking::Account::ApplyTransactionCalculator
  )
end

# Subscribes Reactors to Events.
class Events::Dispatcher < EventSource::EventDispatcher
  on Events::Banking::Account::Created, trigger: Banking::Account::ValidatePendingReactor

  on Events::Banking::Transaction::Created, trigger: Banking::Transaction::ValidatePendingReactor
  on Events::Banking::Transaction::StatusUpdated, trigger: Banking::Account::CalculateBalanceReactor
end

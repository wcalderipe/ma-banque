# Subscribes Reactors to Events.
class Events::Dispatcher < EventSource::EventDispatcher
  on Events::Account::Created, trigger: Account::ValidatePendingReactor
  on Events::Transaction::Created, trigger: Transaction::ValidatePendingReactor
end

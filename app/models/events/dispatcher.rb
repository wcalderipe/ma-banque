# Subscribes Reactors to Events.
class Events::Dispatcher < Lib::EventDispatcher
  on Events::Account::Created, trigger: Reactors::Account::ValidatePending
  on Events::Transaction::Created, trigger: Reactors::Transaction::ValidatePending
end

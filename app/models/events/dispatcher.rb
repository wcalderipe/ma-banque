# Subscribes Reactors to Events.
class Events::Dispatcher < Lib::EventDispatcher
  on Events::Account::Created, trigger: Reactors::Account::CreateValidator
end

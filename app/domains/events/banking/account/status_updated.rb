class Events::Banking::Account::StatusUpdated < Events::Banking::Account::BaseEvent
  data_attributes :status

  def apply(account)
    account.status = status

    account
  end
end

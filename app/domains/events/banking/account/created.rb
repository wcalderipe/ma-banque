class Events::Banking::Account::Created < Events::Banking::Account::BaseEvent
  def apply(account)
    account.status = Banking::Account::PENDING

    account
  end
end

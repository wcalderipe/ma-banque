class Events::Banking::Account::Created < Events::Banking::Account::BaseEvent
  def apply(account)
    account.status = Banking::Account::PENDING
    account.balance = 0

    account
  end
end

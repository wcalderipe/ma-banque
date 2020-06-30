class Events::Account::Created < Events::Account::BaseEvent
  def apply(account)
    account.status = Account::PENDING

    account
  end
end

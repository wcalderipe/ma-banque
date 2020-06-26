class Events::Account::Created < Events::Account::BaseEvent
  def apply(account)
    account.status = Account.statuses.fetch(:pending)

    account
  end
end

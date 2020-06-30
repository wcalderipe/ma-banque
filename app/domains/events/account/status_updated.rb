class Events::Account::StatusUpdated < Events::Account::BaseEvent
  data_attributes :status

  def apply(account)
    account.status = status

    account
  end
end

class Events::Account::BalanceUpdated < Events::Account::BaseEvent
  data_attributes :tx

  # TODO:
  # - Reject non-approved tx
  # - Update tx status to applied
  # - Don't apply twice the same tx
  # - Debit tx
  def apply(account)
    account.balance = credit(account, tx)

    account
  end

  private def credit(account, tx)
    account.balance += tx.balance
  end
end

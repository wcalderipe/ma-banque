class Events::Banking::Account::BalanceUpdated < Events::Banking::Account::BaseEvent
  data_attributes :tx

  # TODO:
  # - Reject non-approved tx
  # - Don't apply twice the same tx
  def apply(account)
    account.balance = tx.credit? ? credit(account, tx) : debit(account, tx)

    account
  end

  private def credit(account, tx)
    account.balance + tx.balance
  end

  private def debit(amount, tx)
    account.balance - tx.balance
  end
end

class Events::Transaction::Created < Events::Transaction::BaseEvent
  data_attributes :account, :kind, :balance

  def apply(tx)
    tx.account = account
    tx.kind = kind
    tx.balance = balance
    tx.status = Transaction::PENDING

    tx
  end
end

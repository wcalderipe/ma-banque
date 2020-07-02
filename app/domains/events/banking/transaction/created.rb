class Events::Banking::Transaction::Created < Events::Banking::Transaction::BaseEvent
  data_attributes :account, :kind, :balance

  def apply(tx)
    tx.account = account
    tx.kind = kind
    tx.balance = balance
    tx.status = Banking::Transaction::PENDING

    tx
  end
end

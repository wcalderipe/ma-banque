class Events::Banking::Transaction::Created < Events::Banking::Transaction::BaseEvent
  data_attributes :account, :kind, :amount

  def apply(tx)
    tx.account = account
    tx.kind = kind
    tx.amount = amount
    tx.status = Banking::Transaction::PENDING

    tx
  end
end

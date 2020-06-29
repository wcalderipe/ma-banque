class Events::Transaction::Created < Events::Transaction::BaseEvent
  data_attributes :kind, :balance

  def apply(tx)
    tx.kind = kind
    tx.balance = balance
    tx.status = Transaction::PENDING

    tx
  end
end

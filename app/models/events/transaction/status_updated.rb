class Events::Transaction::StatusUpdated < Events::Transaction::BaseEvent
  data_attributes :status

  def apply(tx)
    tx.status = status

    tx
  end
end

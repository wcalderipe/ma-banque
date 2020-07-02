class Events::Banking::Transaction::StatusUpdated < Events::Banking::Transaction::BaseEvent
  data_attributes :status

  def apply(tx)
    tx.status = status

    tx
  end
end

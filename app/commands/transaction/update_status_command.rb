class Transaction::UpdateStatusCommand
  include EventSource::Command

  attributes :tx, :status, :metadata

  private def build_event
    return nil if noop?

    Events::Transaction::StatusUpdated.new(
      tx: tx,
      status: status,
      metadata: metadata
    )
  end

  private def noop?
    status == tx.status
  end
end

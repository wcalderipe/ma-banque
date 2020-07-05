class Banking::Account::ApplyTransactionReactor
  def self.call(event)
    return nil unless event.tx.approved?

    Banking::Account::UpdateBalanceCommand.call(
      tx: event.tx,
      metadata: { source: self.to_s }
    )

    Banking::Transaction::UpdateStatusCommand.call(
      tx: event.tx,
      status: Banking::Transaction::APPLIED,
      metadata: { source: self.to_s }
    )
  end
end

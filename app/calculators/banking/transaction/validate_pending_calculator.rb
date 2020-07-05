class Banking::Transaction::ValidatePendingCalculator
  # NOTE: Doesn't nothing now, however when debit transactions are
  # introduced it might check the account balance here.
  def self.call(event)
    Banking::Transaction::UpdateStatusCommand.call(
      tx: event.tx,
      status: Banking::Transaction::APPROVED,
      metadata: { source: self.to_s }
    )
  end
end

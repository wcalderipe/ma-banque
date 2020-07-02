class Banking::Account::CalculateBalanceReactor
  def self.call(event)
    Banking::Account::UpdateBalanceCommand.call(
      tx: event.tx,
      metadata: { source: self.to_s }
    )
  end
end

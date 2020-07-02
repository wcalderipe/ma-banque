class Banking::Account::CalculateBalanceReactor
  def self.call(event)
    Banking::Account::UpdateBalanceCommand.call(
      account: event.tx.account,
      tx: event.tx,
      metadata: { source: self.to_s }
    )
  end
end

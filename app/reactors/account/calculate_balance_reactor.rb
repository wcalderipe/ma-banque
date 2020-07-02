class Account::CalculateBalanceReactor
  def self.call(event)
    Account::UpdateBalanceCommand.call(
      account: event.tx.account,
      tx: event.tx,
      metadata: { source: self.to_s }
    )
  end
end

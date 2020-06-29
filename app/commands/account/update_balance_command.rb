class Account::UpdateBalanceCommand
  include EventSource::Command

  attributes :account, :tx, :metadata

  private def build_event
    Events::Account::BalanceUpdated.new(
      account: account,
      tx: tx,
      metadata: metadata
    )
  end
end

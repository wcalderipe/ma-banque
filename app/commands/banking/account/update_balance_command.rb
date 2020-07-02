class Banking::Account::UpdateBalanceCommand
  include EventSource::Command

  attributes :tx, :metadata

  # TODO: Default tx balance to zero instead of nil
  private def build_event
    Events::Banking::Account::BalanceUpdated.new(
      account: tx.account,
      tx: tx,
      metadata: metadata
    )
  end
end

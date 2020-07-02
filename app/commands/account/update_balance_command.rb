class Account::UpdateBalanceCommand
  include EventSource::Command

  attributes :account, :tx, :metadata

  # NOTE: Now account is inside the tx we might not need both as
  # top-level arguments.
  # TODO: Default tx balance to zero instead of nil
  private def build_event
    Events::Account::BalanceUpdated.new(
      account: account,
      tx: tx,
      metadata: metadata
    )
  end
end

class Banking::Account::UpdateBalanceCommand
  include EventSource::Command

  attributes :tx, :metadata

  private def build_event
    if tx.applied?
      raise Banking::TransactionAlreadyAppliedError.new()
    end

    Events::Banking::Account::BalanceUpdated.new(
      account: tx.account,
      tx: tx,
      metadata: metadata
    )
  end
end

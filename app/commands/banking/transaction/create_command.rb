class Banking::Transaction::CreateCommand
  include EventSource::Command

  attributes :account, :kind, :balance, :metadata

  # TODO: Validate presence of balance
  private def build_event
    Events::Banking::Transaction::Created.new(
      account: account,
      kind: kind,
      balance: balance,
      metadata: metadata
    )
  end
end

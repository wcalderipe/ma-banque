class Transaction::CreateCommand
  include EventSource::Command

  attributes :account, :kind, :balance, :metadata

  private def build_event
    Events::Transaction::Created.new(
      account: account,
      kind: kind,
      balance: balance,
      metadata: metadata
    )
  end
end

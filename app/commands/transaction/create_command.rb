class Transaction::CreateCommand
  include EventSource::Command

  attributes :kind, :balance, :metadata

  private def build_event
    Events::Transaction::Created.new(
      kind: kind,
      balance: balance,
      metadata: metadata
    )
  end
end

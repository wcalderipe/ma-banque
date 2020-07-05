class Banking::Transaction::CreateCommand
  include EventSource::Command

  attributes :account, :kind, :amount, :metadata

  # TODO: Validate presence of amount
  private def build_event
    Events::Banking::Transaction::Created.new(
      account: account,
      kind: kind,
      amount: amount,
      metadata: metadata
    )
  end
end

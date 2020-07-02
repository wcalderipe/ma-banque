class Banking::Account::CreateCommand
  include EventSource::Command

  attributes :metadata

  # TODO: Default balance to zero
  private def build_event
    Events::Banking::Account::Created.new(
      metadata: metadata
    )
  end
end

class Account::CreateCommand
  include EventSource::Command

  attributes :metadata

  private def build_event
    Events::Account::Created.new(
      metadata: metadata
    )
  end
end

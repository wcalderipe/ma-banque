class Account::CreateCommand
  include Lib::Command

  attributes :metadata

  private def build_event
    Events::Account::Created.new(
      metadata: metadata
    )
  end
end

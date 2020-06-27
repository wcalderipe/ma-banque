class Commands::Account::UpdateStatus
  include Lib::Command

  attributes :account, :status, :metadata

  private def build_event
    return nil if noop?

    Events::Account::StatusUpdated.new(
      account: account,
      status: status,
      metadata: metadata
    )
  end

  private def noop?
    status == account.status
  end
end

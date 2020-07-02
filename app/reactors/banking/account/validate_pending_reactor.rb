class Banking::Account::ValidatePendingReactor
  def self.call(event)
    # NOTE: Doesn't nothing now, just set the status to opened and
    # move on.
    Banking::Account::UpdateStatusCommand.call(
      account: event.account,
      status: Banking::Account::OPENED,
      metadata: { source: self.to_s }
    )
  end
end

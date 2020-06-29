class Account::ValidatePendingReactor
  def self.call(event)
    # NOTE: Doesn't nothing now, just set the status to opened and
    # move on.
    Account::UpdateStatusCommand.call(
      account: event.account,
      status: Account::OPENED,
      metadata: { source: self.to_s }
    )
  end
end

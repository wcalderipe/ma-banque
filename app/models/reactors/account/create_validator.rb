class Reactors::Account::CreateValidator
  def self.call(event)
    # NOTE: Doesn't do nothing now, just set the status to opened and
    #       move on.
    Commands::Account::UpdateStatus.call(
      account: event.account,
      status: Account::OPENE,
      metadata: { source: self.to_s }
    )
  end
end

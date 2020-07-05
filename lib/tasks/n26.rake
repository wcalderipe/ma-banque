require "csv"

namespace :n26 do
  namespace :import do
    # NOTE: This task is merely used to have some real data in place.
    desc "Creates MaBanque transactions from N26 transactions report."
    task :csv, [:file, :account_id] => [:environment] do |t, args|
      account = Banking::Account.find(args[:account_id])

      raise "Account not found" unless account

      Transaction = Struct.new(:amount, :kind, keyword_init: true)

      CSV.read(
        args[:file],
        headers: true,
        converters: :numeric
      ).map { |row|
        amount = row[6]
        kind = amount > 0 ? Banking::Transaction::CREDIT : Banking::Transaction::DEBIT

        Transaction.new(
          amount: amount.abs,
          kind: kind
        )
      }.each { |tx|
        puts "Amount: #{tx.amount}\t Kind: #{tx.kind}"

        Banking::Transaction::CreateCommand.call(
          account: account,
          amount: tx.amount,
          kind: tx.kind,
          metadata: { src: "rake:task_n26:import:csv" }
        )
      }
    end
  end
end

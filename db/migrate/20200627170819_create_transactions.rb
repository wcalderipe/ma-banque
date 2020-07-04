class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.decimal :balance, default: 0
      t.string :kind
      t.string :status, default: Banking::Transaction::PENDING

      t.timestamps
    end
  end
end

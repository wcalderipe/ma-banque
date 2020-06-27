class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.decimal :balance
      t.string :type
      t.string :status

      t.timestamps
    end
  end
end

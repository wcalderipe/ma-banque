class CreateTransactionEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :transaction_events do |t|
      t.string :type, null: false
      t.integer :transaction_id, null: false

      t.text :data, null: false
      t.text :metadata, null: false
      t.datetime :created_at, null: false

      t.index :transaction_id
    end
  end
end

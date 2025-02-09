class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :status, default: Banking::Account::PENDING
      t.decimal :balance, default: 0

      t.timestamps
    end
  end
end

class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :status, default: Account.statuses.fetch(:pending)
      t.decimal :balance

      t.timestamps
    end
  end
end

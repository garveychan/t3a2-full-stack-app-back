class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, foreign_key: { on_delete: :cascade }, null: false

      t.string :subscription_id, null: false
      t.string :status, null: false
      t.boolean :cancel_at_period_end, null: false
      t.date :current_period_start, null: false
      t.date :current_period_end, null: false

      t.timestamps
    end
  end
end

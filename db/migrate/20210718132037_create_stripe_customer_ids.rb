class CreateStripeCustomerIds < ActiveRecord::Migration[6.1]
  def change
    create_table :stripe_customer_ids do |t|
      t.references :user, foreign_key: { on_delete: :cascade }, null: false

      t.string :customer_id, null: false

      t.timestamps
    end
  end
end

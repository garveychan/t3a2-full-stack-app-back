class CreateUserAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :user_addresses do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }

      t.string :street_address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :postcode, null: false
      t.string :country, null: false

      t.timestamps
    end
  end
end

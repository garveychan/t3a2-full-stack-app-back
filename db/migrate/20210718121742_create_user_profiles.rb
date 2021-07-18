class CreateUserProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_profiles do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }

      t.string :first_name, null: false
      t.string :last_name, null: false
      t.date :date_of_birth, null: false
      t.string :phone_number, null: false

      t.timestamps
    end
  end
end

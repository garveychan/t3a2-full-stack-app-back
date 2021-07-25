class CreateSignedWaivers < ActiveRecord::Migration[6.1]
  def change
    create_table :signed_waivers do |t|
      t.references :user, foreign_key: { on_delete: :cascade }, null: false
      t.string :name, null: false
      t.text :signatureURI, null: false

      t.timestamps
    end
  end
end

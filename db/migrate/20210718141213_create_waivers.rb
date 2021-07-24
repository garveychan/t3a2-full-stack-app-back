class CreateWaivers < ActiveRecord::Migration[6.1]
  def change
    create_table :waivers do |t|
      t.string :version, null: false
      t.boolean :active, null: false
      t.text :changelog, null: false
      t.text :content, null: false
      t.text :declaration, null: false

      t.timestamps
    end

    add_reference :signed_waivers, :waiver, foreign_key: true, null: false, default: ''
  end
end

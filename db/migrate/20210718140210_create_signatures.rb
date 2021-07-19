class CreateSignatures < ActiveRecord::Migration[6.1]
  def change
    create_table :signatures do |t|
      t.references :signed_waiver, foreign_key: { on_delete: :cascade }, null: false

      t.timestamps
    end
  end
end

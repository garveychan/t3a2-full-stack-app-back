class CreateCheckIns < ActiveRecord::Migration[6.1]
  def change
    create_table :check_ins do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end

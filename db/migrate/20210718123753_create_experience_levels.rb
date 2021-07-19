class CreateExperienceLevels < ActiveRecord::Migration[6.1]
  def change
    create_table :experience_levels do |t|
      t.string :experience_level, null: false

      t.timestamps
    end

    add_reference :user_profiles, :experience_level, foreign_key: true, null: false, default: ''
  end
end

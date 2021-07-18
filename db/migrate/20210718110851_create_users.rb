class CreateUsers < ActiveRecord::Migration[6.1]
  def up
    create_table :users do |t|
      t.timestamps
    end

    execute <<-SQL.squish
        CREATE TYPE user_role AS ENUM ('admin', 'user');
    SQL

    add_column :users, :role, :user_role, null: false, default: 'user'
    add_index :users, :role
  end

  def down
    drop_table :users

    execute <<-SQL.squish
        DROP TYPE user_role;
    SQL
  end
end

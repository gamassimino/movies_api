class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.integer :person_id
      t.integer :movie_id
      t.integer :role

      t.timestamps
    end
  end
end

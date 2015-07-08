class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :username
      t.string :email
      t.string :last_name
      t.string :first_name
      t.string :gender
      t.integer :age
      t.text :about_me
      t.string :status

      t.timestamps null: false
    end
  end
end

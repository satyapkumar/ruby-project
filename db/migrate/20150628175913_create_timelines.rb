class CreateTimelines < ActiveRecord::Migration
  def change
    create_table :timelines do |t|
      t.text :content
      t.references :member, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :timelines, [:member_id, :created_at]
  end
end

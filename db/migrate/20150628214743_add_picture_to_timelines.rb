class AddPictureToTimelines < ActiveRecord::Migration
  def change
    add_column :timelines, :picture, :string
  end
end

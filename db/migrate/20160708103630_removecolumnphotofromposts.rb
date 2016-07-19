class Removecolumnphotofromposts < ActiveRecord::Migration
  def change
  	remove_column :posts, :photo, :binary
  end
end

class AddColumnsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :occupation, :string
  	add_column :users, :dob, :string  	  	
  end
end

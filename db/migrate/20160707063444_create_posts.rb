class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :body
      t.string :name
      t.binary :photo

      t.timestamps null: false
    end
  end
end

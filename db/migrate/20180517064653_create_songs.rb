class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.integer :user_id
      t.string :title
      t.string :singer
      t.string :artist
      t.string :pic
      t.string :file
      t.string :file
      t.text :description
      t.integer :comments_count

      t.timestamps
    end
  end
end

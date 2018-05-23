class AddArtworkToSongs < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :artwork, :string
  end
end

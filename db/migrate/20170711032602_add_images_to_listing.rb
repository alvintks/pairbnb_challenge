class AddImagesToListing < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :image, :json
  end
end

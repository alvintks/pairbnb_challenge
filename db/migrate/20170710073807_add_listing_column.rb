class AddListingColumn < ActiveRecord::Migration[5.0]
  def change
     add_column :listings, :verification_status, :integer, :default => 0
  end
end

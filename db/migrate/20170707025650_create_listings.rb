class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.references :user_id 
      t.string :property_name 
      t.string :description
      t.integer :price_per_night

      t.timestamps
    end
  end
end

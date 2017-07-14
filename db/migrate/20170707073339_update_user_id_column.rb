class UpdateUserIdColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :listings, :user_id_id, :user_id
  end
end

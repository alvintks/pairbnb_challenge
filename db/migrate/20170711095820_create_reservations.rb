class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.references :user
      t.references :listing
      t.date :start_date
      t.date :end_date
    end
  end
end

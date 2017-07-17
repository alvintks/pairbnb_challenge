class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  validate :check_overlapping_dates 

  def check_overlapping_dates
    listing.reservations.each do |old_reservations| 
      return errors.add(:overlapping_dates, "reservation unsuccessful.") if overlap?(self, old_reservations)
    end 
  end 

  def overlap?(x, y)
    (x.start_date - y.end_date) * (y.start_date - x.end_date) > 0
  end 

end
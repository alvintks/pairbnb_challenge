class Listing < ApplicationRecord
  belongs_to :user
  enum verification_status: [:not_verified, :verified]
  mount_uploaders :image, ImageUploader
  validate :image_size_validation
  has_many :reservations


  def self.search(search)
  where("property_name LIKE ? OR description LIKE ?", "%#{search}%", "%#{search}%") 
  end

private 
  def image_size_validation 
     errors[:image] << "should be less than 500KB" if image.size > 0.5.megabytes
  end 

end

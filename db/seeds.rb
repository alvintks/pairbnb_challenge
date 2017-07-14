# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = {}
user['password'] = 'asdf'

ActiveRecord::Base.transaction do
  20.times do 
    user['email'] = Faker::Internet.email
 
    User.create(user)
  end
end 

listing = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  40.times do 
    listing['property_name'] = Faker::Name.name
    listing['price_per_night'] = rand(80..500)
    listing['description'] = Faker::Address.city

    listing['user_id'] = uids.sample

    Listing.create(listing)
  end
end
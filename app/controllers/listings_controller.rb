class ListingsController < ApplicationController
  
  def index 

    if params[:search]
      @listing_search = Listing.search(params[:search]).order("created_at DESC")
    end 

  @listing = Listing.all.where(user_id: params[:user_id]) 
    unless @listing.empty?
      @listing
    else 
      @listing = "You have no new listings"
    end 

  @reservation = Reservation.all.where(user_id: current_user.id)
    if @reservation.empty?
      @reservation = "You have no reservations."
    else 
      @reservation
    end 
  
  @full_listing = Listing.paginate(:page => params[:page], :per_page => 5)
  end 

  def create
    @listing = current_user.listings.new(listing_params)
    @listing.save
    redirect_to user_listings_path
  end 

  def new 
    @listing = Listing.new
  end 

  def edit 
    @editlist = Listing.find(params[:id])
  end 
  
  def show 
    @showlist = Listing.find(params[:id])
  end 

  def update 
    @edit_list = Listing.find(params[:id])
    @edit_list.update(listing_params)
    redirect_to user_listings_path
  end

  def destroy
    @delete_listing = Listing.find(params[:id])
    @delete_listing.destroy
    redirect_to user_listings_path
  end 

private 
  def listing_params 
    params.require(:listing).permit(:property_name, :description, :price_per_night, :verification_status, {image: []}, :remove_image)
  end
end

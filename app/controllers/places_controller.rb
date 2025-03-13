class PlacesController < ApplicationController
  before_action :require_login

  def index
    @places = current_user.places
  end

  def show
    @place = current_user.places.find_by(id: params[:id])
  
    if @place
      @entries = @place.entries.where(user: current_user)  # ✅ Fetch entries for logged-in user
    else
      redirect_to places_path, alert: "Place not found."
    end
  end
  
  

  def new
    @place = Place.new
  end

  def create
    @place = current_user.places.build(place_params)

    if @place.save
      redirect_to places_path, notice: "Place created successfully!"
    else
      flash.now[:alert] = "Error: Could not create place"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def place_params
    params.require(:place).permit(:name)
  end

  def require_login
    redirect_to login_path unless session[:user_id]
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end

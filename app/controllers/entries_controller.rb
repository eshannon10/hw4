class EntriesController < ApplicationController
  before_action :require_login

  def new
    @place = Place.find(params[:place_id])
    @entry = @place.entries.build
  end

  def create
    @place = Place.find(params[:place_id])
    @entry = @place.entries.build(entry_params)
    @entry.user = current_user  # ✅ Link the entry to the logged-in user

    # ✅ Attach image if provided
    if params[:entry][:uploaded_image].present?
      @entry.uploaded_image.attach(params[:entry][:uploaded_image])
    end

    if @entry.save
      redirect_to place_path(@place), notice: "Entry added successfully!"
    else
      flash.now[:alert] = "Error: Could not save entry"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on, :uploaded_image)  
  end

  def require_login
    redirect_to login_path unless session[:user_id]
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end

class AttractionsController < ApplicationController
  before_action :set_attraction, only: [:show, :edit, :update, :destroy]


  def index
    @attractions = Attraction.all
  end

  def new
    @attraction = Attraction.new
  end

  def create
    @attraction = Attraction.create(attraction_params)
    flash[:notice] = "Attraction created"
    redirect_to attraction_path(@attraction)
  end

  def show
    @ride = @attraction.rides.build(user_id: session[:user_id])
  end

  def edit
  end

  def update
    @attraction.update(attraction_params)
    redirect_to attraction_path(@attraction)
  end

  def destroy
    @attraction.destroy
    flash[:notice] = "Attraction has been destroyed"
    redirect_to attractions_path
  end

  private

  def set_attraction
    @attraction = Attraction.find(params[:id])
  end

  def set_user
    @current_user = User.find(session[:user_id])
  end

  def attraction_params
    params.require(:attraction).permit(:name, :tickets, :nausea_rating, :happiness_rating, :min_height)
  end
end

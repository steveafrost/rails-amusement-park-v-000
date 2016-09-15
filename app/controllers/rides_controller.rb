class RidesController < ApplicationController
  def index
  end

  def new
  end

  def create
    @ride = Ride.create(user_id: params[:user_id], attraction_id: params[:attraction_id])
    flash[:notice] = @ride.take_ride
    redirect_to user_path(@ride.user)
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

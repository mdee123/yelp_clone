class RestaurantsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user_id = current_user.id
    if @restaurant.save
      redirect_to '/restaurants'
    else
      render 'new'
    end
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :image)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if current_user.id == @restaurant.user_id
      @restaurant.update(restaurant_params)
      redirect_to '/restaurants'
    else
      redirect_to '/restaurants', alert: 'You cannot edit a restaurant you didn\'t create'
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if current_user.id == @restaurant.user_id
      @restaurant.destroy
      flash[:notice] = 'Restaurant deleted successfully'
      redirect_to '/restaurants'
    else
      redirect_to '/restaurants', alert: 'You cannot delete a restaurant you didn\'t create'
    end
  end

end

class RestaurantsController < ApplicationController
  before_action :set_restaurant, except: [:index, :feeds, :ranking]

  def index
    @restaurants = Restaurant.page(params[:page]).per(9)
    @categories = Category.all
  end

  def show
    #@restaurant = Restaurant.find(params[:id])
    # @user = Comment.users.find(params[:id])
    @comment = Comment.new
  end

  def feeds
    @recent_restaurants = Restaurant.order(created_at: :desc).limit(5)
    @recent_comments = Comment.order(created_at: :desc).limit(5)
  end

  def ranking
    @top_restaurants = Restaurant.order(favorites_count: :desc).limit(10)
  end

  def dashboard
    # @restaurant = Restaurant.find(params[:id])
  end

  def favorite
    Favorite.create(restaurant: @restaurant, user: current_user)
    redirect_back(fallback_location: root_path)
    @restaurant.favorites_count += 1
    @restaurant.save
  end

  def unfavorite
    favorite = Favorite.where(restaurant: @restaurant, user: current_user)
    favorite.delete_all
    redirect_back(fallback_location: root_path)
    @restaurant.favorites_count-=1
    @restaurant.save
  end

  def like
    Like.create(restaurant: @restaurant, user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def unlike
    like = Like.where(restaurant: @restaurant, user: current_user)
    like.delete_all
    redirect_back(fallback_location: root_path)
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

end


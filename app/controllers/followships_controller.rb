class FollowshipsController < ApplicationController
  def create
    @following = User.find(params[:following_id])
  end
end

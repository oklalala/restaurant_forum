class FollowshipsController < ApplicationController
  def create
    @followship = current_user.followships.build(following_id: params[:following_id])

    if @followship.save
      flash[:notice] = "You followed #{}"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id]).first
    #不能用find 因為find是找主鍵，following_id不是主鍵 用.first是因為where回傳的是集合
    @followship.destroy
    #若不用.first 需要用destroy_all
    flash[:alert] = "#{@followship.following.email} destroyed"
    redirect_back(fallback_location: root_path)
  end
end

class UsersController < ApplicationController
  def show
    @user=User.find(params[:id])
    @commented_restaurants = @user.restaurants
  end
  def edit
  end
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = "#{@user.name} was successfully updated"
    else
      render :edit
      flash[:alert] = "#{@user.name} was failed to update"
    end
  end


  def user_params
    params.require(:user).permit(:name, :email, :intro, :avatar)
  end

end

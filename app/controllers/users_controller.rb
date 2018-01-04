class UsersController < ApplicationController
  def index
    @users=User.all
  end

  def show
    @user=User.find(params[:id])
    @commented_restaurants = @user.restaurants
  end

  def edit
    # @user=User.find(params[:id])
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
      flash[:notice] = "#{current_user.name} was successfully updated"
    else
      render :edit
      flash[:alert] = "#{current_user.name} was failed to update"
    end
  end


  def user_params
    params.require(:user).permit(:name, :email, :intro, :avatar)
  end

end

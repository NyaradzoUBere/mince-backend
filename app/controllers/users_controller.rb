class UsersController < ApplicationController
  def index
    @users = User.all

    render json: @users
  end

  def show
    @user = User.find(params[:id])

    render json: @user, include: %i[recipes shopping_list]
  end
  
  def create
    @user = User.create(
      name: params[:name],
      username: params[:username]
    )
    
    redirect_to("http://localhost:3001/user.html?user_id=#{@user.id}")
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    render json: { message: "User #{@user.username} has been deleted!" }
  end
  
  def update
    @user = User.find(params[:id])
    
    @user.shopping_list.ingredients << params[:shopping_list]
    @user.shopping_list.save!
    
    # redirect_to("http://localhost:3001/user.html?user_id=#{@user.id}")
    render json: @user, include: %i[recipes shopping_list]
  end
end

class UsersController < ApplicationController
  def index
    @user = User.last
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.save
       redirect_to action: :index
      # redirect_to  users_path
    else
      render :new
    end
      
    # first_name: params[:username],
    #                     last_name: params[:username],  
    #                     username: params[:username], 
    #                     email: params[:username],
    #                     email_confirmation: params[:username],
    #                     password: params[:password],
    #                     password_confirmation: params[:password_confirmation],
    #                     password_hint: params[:password_confirmation])

  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :username,
      :email,
      :email_confirmation,
      :password,
      :password_confirmation,
      :password_hint
    )
  end
end

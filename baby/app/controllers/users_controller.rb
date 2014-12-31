class UsersController < ApplicationController
  def welcome
  end

  def signup
    @user = User.new
  end

  def login
  end

  def logout
    cookies.delete(:token)
    redirect_to root_url
  end

  def create_login_session
    user = User.find_by_name(params[:name])
    if user && user.authenticate(params[:password])
      cookies.permanent[:token] = user.token
      redirect_to root_url
    else
      redirect_to :login
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      cookies.permanent[:token] = @user.token
      redirect_to :root
    else
      render :signup
    end
  end

  private
   def user_params
     params.require(:user).permit!
   end
end

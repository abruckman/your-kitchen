class UsersController < ApplicationController
  before_filter :require_login, except: [:create, :new]

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      if log_in(@user)
        redirect_to @user
      else
        redirect_to '/'
      end
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      flash[:notice]= "unable to save changes"
      redirect_to @user
    end
  end

  private
    def user_params
      params.require(:user).permit(:id, :username, :email, :password, :bio, :image_link)
    end
end

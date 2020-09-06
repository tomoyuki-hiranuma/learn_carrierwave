class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if params[:image_name]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image_name]
      File.binwrite("app/assets/images/user_images/#{@user.image_name}", image.read)
    end

    if @user.save
      redirect_to users_url
    else
      render :new
    end
  end
  
  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    redirect_to "/users"
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :image_name)
  end

end

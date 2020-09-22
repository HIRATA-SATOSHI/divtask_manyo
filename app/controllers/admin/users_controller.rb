class Admin::UsersController < ApplicationController
  # before_action :set_user, only: [:show, :edit]

  def new
    @users = User.new
    # binding.pry
  end

  def create
    @users = User.new(user_params)

    if @users.save
      redirect_to admin_user_url(@users), notice: "ユーザー「#{@users.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    @users = User.new(user_params)
  end

  def show
    @users = User.new(user_params)
  end

  def index
    @users = User.all
  end

  def update
    @users = User.find(params[:id])

    if @users.update(user_params[:id])
      redirect_to admin_user_url(@users), notice: "ユーザー「#{@users.name}」を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @users = User.find(params[:id])
    @users.destroy
    redirect_to admin_user_url, notice: "ユーザー「#{@users.name}」を削除しました"
  end
 
  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def require admin
      redirect_to root_path unless current_user.admin?
  end
  # def set_user
  #   @users = User.find(params[:id])
  # end
end

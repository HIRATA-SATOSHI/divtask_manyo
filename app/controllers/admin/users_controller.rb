class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy]
  before_action :require_admin

  def new
    # binding.pry
    @user = User.new
   
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    # @user = User.find(user_params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: 更新しました！
    else
      render :edit
    end
  end

  def show
    # binding.pry
    # @user = User.find(user_params[:id])
  end

  def index
    @users = User.all
  end

  def destroy
    @user.destroy
    flash[:notice] = "ユーザー #{@user.name} を削除しました"
    redirect_to admin_user_path
  end
 
  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
    
  end

  def require_admin
      redirect_to root_path unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

end

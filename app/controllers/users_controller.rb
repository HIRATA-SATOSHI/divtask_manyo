class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:show]
  skip_before_action :login_required
  # before_action :set_user, only: [:show, :edit]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = '登録しました'
      redirect_to user_path(@user.id)      
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "投稿を編集しました！"
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  # def set_user
  #   @user = User.find(params[:id])
  # end
end

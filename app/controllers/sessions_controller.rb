class SessionsController < ApplicationController
  # skip_before_action :login_required
  def new
    unless logged_in?
      @user = User.new
    else
      redirect_to root_path, notice: 'すでにログインしています。'
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        redirect_to user_path(user.id)
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
  def destroy
    session.delete(:user_id)
    flash[:nitice] = 'ログアウトしました'
    redirect_to new_session_path
  end
end

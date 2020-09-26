class ApplicationController < ActionController::Base
    before_action :login_required
    before_action :set_current_user
    protect_from_forgery with: :exception
    include SessionsHelper
    
    # def authenticate_user
    #     # 現在ログイン中のユーザが存在しない場合、ログインページにリダイレクトさせる。
    #   if @current_user == nil
    #     flash[:notice] = t('notice.ログインが必要です！')
    #     redirect_to new_session_path
    #   end
    # end

  private
  def login_required
    redirect_to new_session_path unless current_user
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end
end

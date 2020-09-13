class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper

    def authenticate_user
        # 現在ログイン中のユーザが存在しない場合、ログインページにリダイレクトさせる。
      if @current_user == nil
        flash[:notice] = t('notice.ログインが必要です！')
        redirect_to new_session_path
      end
    end

  private
    def logged_in
      unless logged_in?
        redirect_to new_session_path
      end
    end
end

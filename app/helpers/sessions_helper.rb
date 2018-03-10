module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end


  # 現在のユーザー
  def current_user
    # @current_userがnilでなければUser.find_by( id: session[:user_id] )を代入
    @current_user ||= User.find_by( id: session[:user_id] )
  end

  # logged_in? -> return boolean
  def logged_in?
    # @current_user == nil ログアウト時 / @current_user != nil ログイン時
    !current_user.nil?
  end

  # ログアウト
  def log_out
    session.delete(:user_id)
    @current_user = nil # @current_userをnilにもどす
  end

end

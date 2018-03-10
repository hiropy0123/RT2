module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end


  # 現在のユーザー
  def current_user
    @current_user ||= User.find_by( id: session[:user_id] )
  end

  # logged_in? -> return boolean
  def logged_in?
    !current_user.nil?
  end

end

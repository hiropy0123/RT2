module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  # ユーザーのセッションを永続的にする
  def remember(user)
    # 永続セッションのためにユーザーをデータベースに記憶する
    user.remember
    # 署名付きcookieにuser.idを保存
    cookies.permanent.signed[:user_id] = user.id
    # user.remember_tokenをCookieに保存
    cookies.permanent[:remember_token] = user.remember_token

  end


  # 現在のユーザー
  def current_user
    # @current_userがnilでなければUser.find_by( id: session[:user_id] )を代入
    # @current_user ||= User.find_by( id: session[:user_id] )
    # 永続セッションの場合は、session[:user_id]が存在すれば、一時セッションからユーザーを取り出す。それ以外の場合は、cookies[:user_id]からユーザーを取り出して対応する永続セッションにログイン
    if ( user_id = session[:user_id] ) # session[:user_id]が存在すれば、user_idに代入する（代入演算子   ）

      @current_user ||= User.find_by(id: user_id)

    elsif ( user_id = cookies.signed[:user_id] )
      # わざとエラーを引き起こす'raise' を入れてテストがパスしてしまう場合は問題！その箇所がテストされていないことを示す。
      # raise
      user = User.find_by(id: user_id)

      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end

    end

  end

  # logged_in? -> return boolean
  def logged_in?
    # @current_user == nil ログアウト時 / @current_user != nil ログイン時
    !current_user.nil?
  end

  # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # ログアウト
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil # @current_userをnilにもどす
  end

end

class SessionsController < ApplicationController
  # ログインページの表示
  def new
  end

  # ログイン処理
  def create
    user = User.find_by( email: params[:session][:email].downcase )
    if user && user.authenticate(params[:session][:password])
      # ログインフォームで入力されたメールアドレスからユーザーの存在を確認し、さらにパスワードが有効かどうか
      log_in user
      remember user
      redirect_to user
    else
      flash.now[:danger] = '入力されたメールアドレスとパスワードの組み合わせが正しくありません。'
      render 'new'
    end
  end

  # ログアウト（セッションからユーザーIDを削除）
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end

class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by( email: params[:session][:email].downcase )
    if user && user.authenticate(params[:session][:password])
      # ログインフォームで入力されたメールアドレスからユーザーの存在を確認し、さらにパスワードが有効かどうか
    else
      flash.now[:danger] = '入力されたメールアドレスとパスワードの組み合わせが正しくありません。'
      render 'new'
    end
  end

  def destroy

  end
end

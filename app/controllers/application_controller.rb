class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # アプリ全体からアクセス可能にする
  include SessionsHelper
end

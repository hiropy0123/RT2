require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def Setup
    @user = users(:michael)
    remember(@user)
  end

  # １．fixtureでuser変数を定義
  # ２．渡されたユーザーをrememberメソッドで記憶する
  # ３．current_userが渡されたユーザーと同じであることを確認

  test 'current_user returns right user when session is nil' do
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test 'current_user returns nil when remember digest is wrong' do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end


end

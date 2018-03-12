class User < ApplicationRecord
  # attr_accessorでアクセス可能なremember_token属性を作成
  attr_accessor :remember_token

  before_save { self.email = email.downcase }
  validates :name,
            presence: true,
            length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,
            presence: true,
            length: { maximum: 60 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password,
            presence: true,
            length: { minimum: 6 }




  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

  # ランダムなトークンを生成し返す
    def new_token
      SecureRandom.urlsafe_base64
    end

  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    # 自身のremember_token属性に生成されたトークンを保存
    self.remember_token = User.new_token
    # データベースに保存するのはremeber_digest
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    # ローカル変数remember_tokenはattr_accessorで定義したremember_tokenとは全く別物！
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

end

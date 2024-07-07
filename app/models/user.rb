class User < ApplicationRecord
  # [remember_token]という仮想の属性を作成します。
  attr_accessor :remember_token
  # before_save { self.email = email.downcase }
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true, length: { maximum: 50 },
  #                   format: { with: VALID_EMAIL_REGEX },
  #                   uniqueness: true
  validates :store_id, presence: true, uniqueness: true
  has_secure_password#パスワードのハッシュ化と認証機能を提供
  validates :password, presence: true, length: { minimum: 6 }


  #ユーザーを記憶するには、記憶トークンを作成してそのトークンをダイジェストに変換したものをデータベースに保存

  #渡された文字列のハッシュ値を生成。
  def User.digest(string) #digestメソッド：渡された文字列をハッシュ化
    cost =
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)#saltを自動生成し、パスワードと結合してハッシュ化を行います。
  end

  #ランダムなトークンを生成。
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  #永続セッションの為にハッシュ化したトークンをデータベースに記憶。
  #パスワードでなくログイン状態の維持だけなので、attributeでバリデーションを素通りさせ、処理を高速化。
  # def remember
  #   self.remember_token = User.new_token
  #   update_attribute(:remember_digest, User.digest(remember_token))
  # end

  #トークンがダイジェストと一致すればtrueを返す。
  def authenticaed?(remember_token)
    # ダイジェストが存在しない場合はfalseを返して終了します。
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  #ユーザーのログイン情報を破棄します。
  def forget
    update(remember_digest: nil)
  end
end

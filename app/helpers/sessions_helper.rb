module SessionsHelper
  # ログインしたユーザーのIDをセッションに保存する（ユーザーのブラウザ内にある一時的cookiesに暗号化済みのuser.idが自動で生成される）
  def log_in(user)
    session[:user_id] = user.id
  end

  # 永続的セッションを記憶します（Userモデルを参照）
  # def remember(user)
  #   user.remember
  #   cookies.permanent.signed[:user_id] = user.id
  #   cookies.permanent[:remember_token] = user.remember_token
  # end

  #永続的セッションを破棄します
  def forget(user)
    user.forget#Userモデル参照
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # セッションと@current_userを破棄します
  def log_out
    forget(current_user) if current_user
    session.delete(:user_id)#セッションからユーザーIDを削除
    @current_user = nil
  end

  # 一時的セッションにいるユーザーを返します。
  # それ以外の場合はcookiesに対応するユーザーを返します。
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @currtent_user = user
      end
    end
  end

  #ユーザーがログインしているかどうかを確認します。(条件が true の場合は false を返し、false の場合は true を返します。)
  def logged_in?
    !current_user.nil?
  end
end

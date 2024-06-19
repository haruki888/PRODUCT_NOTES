module SessionsHelper
  # ユーザーのブラウザ内にある一時的cookiesに暗号化済みのuser.idが自動で生成される（ログインしたユーザーのIDをセッションに保存する）
  def log_in(user)
    session[:user_id] = user.id
  end

  # セッションと@current_userを破棄します
  def log_out
    session.delete(:user_id)#セッションからユーザーIDを削除
    @current_user = nil
  end

  # 現在ログイン中のユーザーがいる場合オブジェクトを返します。
  def current_user
    if session[:user_id]#session[:user_id] が存在するかどうかを確認し,ユーザーがログインした際にセッションに保存されたユーザーIDを保持します。
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  #条件が true の場合は false を返し、false の場合は true を返します。
  def logged_in?
    !current_user.nil?
  end
end

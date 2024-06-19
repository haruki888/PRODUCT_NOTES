class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])#authenticateメソッドはユーザーの認証情報が有効であるかどうかを確認
      log_in user#log_in(user)
      redirect_to user#redirect_to(user)
    else
      flash.now[:danger] = "認証に失敗しました。"
      render 'new', status: :unprocessable_entity#status: :unprocessable_entityはフォームのバリデーションエラーや認証エラーな
    end                                          #ど、ユーザーの入力に起因する問題が発生した場合に有効。
  end

  def destroy
    log_out
    flash[:success] = "ログアウトしました。"
    redirect_to root_url
  end
end

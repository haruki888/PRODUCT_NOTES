class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user# 保存成功後、ログインします。
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user #(redirect_to user_url(@user)
    else
      render 'new', status: :unprocessable_entity#422 クライアントから送信されたデータが無効で処理できない場合に使用
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :store_id, :password, :password_confirmation)
    end
end

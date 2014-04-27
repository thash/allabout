class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to root_path, notice: 'ユーザを作成しました。左のフォームからログインしてください'
    else
      render new_user_path, alert: 'ユーザ登録に失敗しました'
    end
  end

  def signin
    if login(params[:email], params[:password])
      redirect_to root_path, notice: 'ログインしました'
    else
      redirect_to root_path, alert: 'ログインに失敗しました'
    end
  end

  def signout
    if logout
      redirect_to root_path, notice: 'ログアウトしました'
    else
      redirect_to root_path, alert: 'ログアウトに失敗しました'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :icon)
  end
end

class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = "ログインしました"
      redirect_to user
    else
      flash[:danger] = "ユーザー名/パスワードが誤っています"
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end

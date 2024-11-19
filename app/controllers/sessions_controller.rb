class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = 'ログインしました'
      redirect_to home_path
    else
      flash[:error] = 'メールアドレスまたは、パスワードが間違っています'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to welcome_index_path
  end
end
class HomeController < ApplicationController
  before_action :require_login  # Sorceryの認証を使う

  def index
    @recipes = current_user.recipes  # ログインユーザーのレシピを取得
  end

  private

  def require_login
    redirect_to login_path unless logged_in?  # Sorceryのlogged_in?メソッドでログイン状態を確認
  end
end

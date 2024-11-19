class RecipesController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def new
    @recipe = Recipe.new
    @recipe.quantities.build  # 数量の初期化（フォームに表示するため）
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe), notice: "レシピを作成しました"
    else
      render :new, alert: "エラーが発生しました"
    end
  end

  def show
    @recipe = Recipe.find(params[:id])  # id パラメータでレシピを取得
  end
  
  private

  def recipe_params
    #params.require(:recipe).permit(:title, :description, images: [], quantities_attributes: [:ingredient, :amount, :_destroy])
    params.require(:recipe).permit(:title, :description, images: [], quantities_attributes: [:ingredient_name, :amount])

  end

  def require_login
    unless current_user
      redirect_to login_path, alert: "ログインが必要です"
    end
  end
end

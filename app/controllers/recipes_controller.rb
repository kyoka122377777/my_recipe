class RecipesController < ApplicationController
  before_action :require_login, only: [:new, :create, :show, :edit]

  def index
    if params[:query].present?
      @recipes = Recipe.joins(:quantities)
                       .where("recipes.title ILIKE ? OR quantities.ingredient_name ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
                       .distinct
    else
      #@recipes = current_user.recipes
      @recipes = [] 
    end
  end
  

  def new
    @recipe = Recipe.new
    10.times { @recipe.quantities.build }
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe), notice: "レシピを作成しました"
    else
      flash.now[:alert] = "エラーが発生しました"
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def search
    if params[:query].present?
      @recipes = current_user.recipes.joins(:quantities)
                      .where("recipes.title ILIKE ? OR quantities.ingredient_name ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
                      .distinct
      render :index # index ビューをレンダリング
    else
      redirect_to home_path # クエリが空の場合はホームにリダイレクト
    end
  end
  
  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description, images: [], quantities_attributes: [:id, :ingredient_name, :amount, :_destroy])
  end

  def create_tags(ingredient_names)
    ingredient_names.each do |ingredient_name|
      tag = Tag.find_or_create_by(name: ingredient_name)
      RecipeTag.create(recipe_id: @recipe.id, tag_id: tag.id)
    end
  end

  def require_login
    unless current_user
      redirect_to login_path, alert: "ログインが必要です"
    end
  end
end

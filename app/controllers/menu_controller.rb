class MenuController < ApplicationController
  before_action :require_login

  def index
    # 必要に応じて選択肢を動的に生成
  end
end

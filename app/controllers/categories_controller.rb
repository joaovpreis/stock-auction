class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    category = Category.new params_category

    if category.save
      redirect_to root_path, notice: 'Categoria criada com sucesso.' and return
    end

    flash.now[:notice] = 'Não foi possível criar a categoria.'
    render 'new'

  end

  private

  def params_category
    params.require(:category).permit(:name)
  end
end

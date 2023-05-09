class CategoriesController < ApplicationController
  before_action :is_admin?, only: [:new, :create, :edit, :update]

  def show
    @category = Category.find params[:id]
  end

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new params_category

    if @category.save
      redirect_to @category, notice: 'Categoria criada com sucesso.' and return
    end

    flash.now[:notice] = 'Não foi possível criar a categoria.'
    render 'new'

  end

  def edit
    @category = Category.find params[:id]
  end

  def update
    @category = Category.find params[:id]

    if @category.update params_category
      redirect_to @category, notice: 'Categoria atualizada com sucesso.' and return
    end

    flash.now[:notice] = 'Não foi possível atualizar a categoria.'
    render 'edit'

  end

  private

  def params_category
    params.require(:category).permit(:name)
  end
end

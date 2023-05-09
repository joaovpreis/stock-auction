class ItemsController  < ApplicationController
  before_action :is_admin?, only: [:new, :create]
  def show 
    @item = Item.find params[:id]
  end

  def new
    @item = Item.new
  end

  def create 
    @item = Item.new(params.require(:item).permit(:name, :description, :weight, :width, :height, :length, :category_id, :photo))
    if @item.save
      redirect_to @item, notice: 'Item criado com sucesso.' and return
    end
    flash.now[:notice] = 'Não foi possível criar o item.'
    render 'new'
    
  end
end
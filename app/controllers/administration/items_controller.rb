# frozen_string_literal: true

module Administration
  class ItemsController < AdministrationController
    def index
      @items = Item.all
     end

    def update
      @item = Item.find(params[:id])
      if @item.update(has_discount: true)
      @item.update_attributes(item_params)
      flash[:notice] = 'Votre modification a été prise en compte'
     else
      flash[:notice] = 'Votre modification a pas été prise en compte'
      end
      redirect_to administration_items_path
    end
 

    def item_params
      params.require(:item).permit(:original_price , :has_discount, :discount_percentage)
    end
  end
end

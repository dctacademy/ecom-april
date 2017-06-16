class CartLineItemsController < ApplicationController

	def index
		@cart_line_items = current_user.cart_line_items
		@order = Order.new
	end

	def create
		@cart_line_item = CartLineItem.new(cart_line_item_params)
		@cart_line_item.user_id = current_user.id
		@cart_line_item.save_or_update
		redirect_to cart_line_items_path, notice: "You have added the product to the cart"
	end

	def update
		@cart_line_item = CartLineItem.find(params[:id])
		@cart_line_item.update_attributes(cart_line_item_params)
		redirect_to cart_line_items_path, notice: "Successfully Updated"
	end

	def destroy
		@cart_line_item = CartLineItem.find(params[:id])
		@cart_line_item.destroy 
		redirect_to cart_line_items_path, notice: "removed from the cart"
	end

	private
	def cart_line_item_params
		params[:cart_line_item].permit(:product_id, :quantity)
	end
end

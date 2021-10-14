class OrderItemsController < ApplicationController
	def create
		
	end

	def edit
		
	end

	def update
		
		
	end

	def destroy
		
	end

	private

	def order_params
		params.require(:order_item).permit(:product_id, :quantity)
	end
end

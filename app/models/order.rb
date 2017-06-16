class Order < ActiveRecord::Base

	has_many :order_products
	belongs_to :user

=begin 
	before_validation / after_validation 
	before_save / after_save ( create & update )
	before_create / after_create ( create )
	before_destroy / after_destroy 
=end

	# call back
	before_validation :set_order_details
	after_create :generate_order_products 

	validates_presence_of :user_id, :order_date, :order_number, :total_amount
	validates_numericality_of :user_id, :total_amount, greater_than: 0


	def set_order_details
		self.order_number = "DCT#{Random.rand(1000)}"
		self.order_date = Date.today
		self.total_amount = 1 # todo...
	end

	def generate_order_products
		# CartLineItem.where('user_id = ?', self.user_id)
		cart_line_items = self.user.cart_line_items
		cart_line_items.each do |cart_line_item| 
			order_product = OrderProduct.new 
			order_product.order_id = self.id
			order_product.product_id = cart_line_item.product_id
			order_product.quantity = cart_line_item.quantity
			order_product.price = cart_line_item.product.price
			order_product.total = order_product.price * order_product.quantity
			order_product.save
		end
		CartLineItem.delete(self.user.cart_line_items.pluck(:id))
	end

end

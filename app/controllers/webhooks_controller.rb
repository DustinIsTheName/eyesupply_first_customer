class WebhooksController < ApplicationController

	skip_before_filter :verify_authenticity_token, :only => [:customer, :order]

	def customer
		id = params[:id]
		customer = ShopifyAPI::Customer.find(id)
		Function.check_single_customer(customer)

		head :ok, content_type: "text/html"
	end

	def order
		customer_id = params[:customer][:id]
		customer = ShopifyAPI::Customer.find(customer_id)
		Function.check_single_customer(customer)

		head :ok, content_type: "text/html"
	end

end

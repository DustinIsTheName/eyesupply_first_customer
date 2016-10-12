class Function < ActiveRecord::Base

	CYCLE = 0.5
	@start_time = Time.now

	def self.puts_hello
		puts ShopifyAPI::Base.site
		puts ShopifyAPI::Customer.find( :all, :params => { :limit => 1 } )
	end

	def self.how_long_a_nap
	  stop_time = Time.now
	  processing_duration = stop_time - @start_time
	  wait_time = (CYCLE - processing_duration).ceil
	  sleep wait_time if wait_time > 0
	  @start_time = Time.now
	end

	def self.check_single_customer(c)
		old_tags = c.tags

		if c.orders_count > 0
			c.tags = c.tags.remove_tag('First Time')
			puts Colorize.magenta('Customer ' << c.first_name << ' ' << c.last_name << ' is not a first time customer. ') << Colorize.red('Remove Tag!')
		else
			c.tags = c.tags.add_tag('First Time')
			puts Colorize.cyan('Customer ' << c.first_name << ' ' << c.last_name << ' is a first time customer. ') << Colorize.green('Add Tag!')
		end

		unless c.tags == old_tags
			Function.how_long_a_nap
			c.save
		end

	end

	def self.check_all_customers
		customer_count = ShopifyAPI::Customer.count
		nb_pages = (customer_count / 250.0).ceil

		1.upto(1) do |page|

			unless page == 1
				Function.how_long_a_nap
		  end

		  customers = ShopifyAPI::Customer.find( :all, :params => { :limit => 250, :page => page } )

		  customers.each do |c|
				Function.check_single_customer(c)
		  end

		end		

		puts Colorize.green('All done!')
	end

end
require File.expand_path('../boot', __FILE__)

require 'rails/all'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EyesupplyFirstCustomer
  class Application < Rails::Application
    require 'ext/string'
    require 'ext/colorize'

    config.active_record.raise_in_transactional_callbacks = true

    ShopifyAPI::Base.site = "https://#{ENV["API_KEY"]}:#{ENV["PASSWORD"]}@eyesupply.myshopify.com/admin"
  end
end

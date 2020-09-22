# frozen_string_literal: true

EasyPost.api_key = 'YOUR_API_KEY_HERE'

SolidusEasypost.configure do |config|
  # Purchase labels from EasyPost when shipping shipments in Solidus?
  # config.purchase_labels = true

  # A class that responds to `#shipping_method_for`, accepting an
  # `EasyPost::Rate` instance and returning the shipping method for
  # that rate.
  # config.shipping_method_selector_class = 'SolidusEasypost::ShippingMethodSelector'
end

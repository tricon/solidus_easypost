# frozen_string_literal: true

EasyPost.api_key = 'YOUR_API_KEY_HERE'

SolidusEasypost.configure do |config|
  # Purchase labels from EasyPost when shipping shipments in Solidus?
  # config.purchase_labels = true
end

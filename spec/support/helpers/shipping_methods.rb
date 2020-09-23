module SolidusEasypost
  module TestHelpers
    module ShippingMethods
      def create_easypost_shipping_methods
        [
          "USPS Express",
          "USPS First",
          "USPS ParcelSelect",
          "USPS Priority",
        ].each do |name|
          create(:shipping_method, admin_name: name, available_to_users: true)
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.include SolidusEasypost::TestHelpers::ShippingMethods
end

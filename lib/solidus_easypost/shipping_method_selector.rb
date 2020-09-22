# frozen_string_literal: true

module SolidusEasypost
  class ShippingMethodSelector
    def shipping_method_for(rate)
      name = "#{rate.carrier} #{rate.service}"

      ::Spree::ShippingMethod.find_or_create_by(admin_name: name) do |shipping_method|
        shipping_method.name = name
        shipping_method.available_to_users = false
        shipping_method.code = rate.service
        shipping_method.calculator = ::Spree::Calculator::Shipping::FlatRate.create
        shipping_method.shipping_categories = [::Spree::ShippingCategory.first]
      end
    end
  end
end

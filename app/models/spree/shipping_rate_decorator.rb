module Spree
  module ShippingRateDecorator
    def name
      read_attribute(:name)
    end
  end
end

Spree::ShippingRate.prepend Spree::ShippingRateDecorator

# frozen_string_literal: true

module SolidusEasypost
  class Estimator
    def shipping_rates(package, _frontend_only = true)
      easypost_rates = package.easypost_shipment.rates.sort_by(&:rate)

      shipping_rates = easypost_rates.map(&method(:build_shipping_rate)).compact
      shipping_rates.min_by(&:cost)&.selected = true

      shipping_rates
    end

    private

    def build_shipping_rate(rate)
      shipping_method = build_shipping_method(rate)
      return unless shipping_method.available_to_users?

      ::Spree::ShippingRate.new(
        name: "#{rate.carrier} #{rate.service}",
        cost: rate.rate,
        easy_post_shipment_id: rate.shipment_id,
        easy_post_rate_id: rate.id,
        shipping_method: shipping_method,
      )
    end

    def build_shipping_method(rate)
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

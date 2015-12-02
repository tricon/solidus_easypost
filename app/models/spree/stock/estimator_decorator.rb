Spree::Stock::Estimator.class_eval do
  def shipping_rates(package)
    shipment = package.easypost_shipment
    rates = shipment.rates.sort_by { |r| r.rate.to_i }

    if rates.any?
      rates.each do |rate|
        spree_rate = Spree::ShippingRate.new(
          name: "#{ rate.carrier } #{ rate.service }",
          cost: rate.rate,
          easy_post_shipment_id: rate.shipment_id,
          easy_post_rate_id: rate.id,
          shipping_method: find_or_create_shipping_method(rate)
        )

        package.shipping_rates << spree_rate if spree_rate.shipping_method.frontend?
      end

      # Sets cheapest rate to be selected by default
      if package.shipping_rates.any?
        package.shipping_rates.min_by(&:cost).selected = true
      end

      package.shipping_rates
    else
      []
    end
  end

  private

  # Cartons require shipping methods to be present, This will lookup a
  # Shipping method based on the admin(internal)_name. This is not user facing
  # and should not be changed in the admin.
  def find_or_create_shipping_method(rate)
    method_name = "#{ rate.carrier } #{ rate.service }"
    shipping_method = Spree::ShippingMethod.find_or_initialize_by(admin_name: method_name)

    unless shipping_method.persisted?
      shipping_method.update(
        name: method_name,
        admin_name: method_name,
        display_on: :back_end,
        code: rate.service,
        calculator: Spree::Calculator::Shipping::FlatRate.create,
        shipping_categories: [Spree::ShippingCategory.first]
      )
    end

    shipping_method
  end

  def build_shipment(from_address, to_address, parcel)
    shipment = ::EasyPost::Shipment.create(
      :to_address => to_address,
      :from_address => from_address,
      :parcel => parcel
    )
  end
end

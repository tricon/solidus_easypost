Spree::Stock::Estimator.class_eval do
  def shipping_rates(package)
    order = package.order

    from_address = package.stock_location.easypost_address
    to_address = order.ship_address.easypost_address
    parcel = build_parcel(package)
    shipment = build_shipment(from_address, to_address, parcel)
    rates = shipment.rates.sort_by { |r| r.rate.to_i }

    if rates.any?
      rates.each do |rate|
        package.shipping_rates << Spree::ShippingRate.new(
          name: "#{ rate.carrier } #{ rate.service }",
          cost: rate.rate,
          easy_post_shipment_id: rate.shipment_id,
          easy_post_rate_id: rate.id,
          shipping_method: find_or_create_shipping_method(rate)
        )
      end

      # Sets cheapest rate to be selected by default
      package.shipping_rates.first.selected = true

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

    unless shipping_method = Spree::ShippingMethod.find_by(admin_name: method_name)
      Spree::ShippingMethod.new(
        name: method_name,
        admin_name: method_name,
        display_on: :back_end,
        code: rate.service,
        calculator: Spree::ShippingCalculator.first,
        shipping_categories: [Spree::ShippingCategory.first]
      )
    end
  end

  def build_parcel(package)
    total_weight = package.contents.sum do |item|
      item.quantity * item.variant.weight
    end

    parcel = ::EasyPost::Parcel.create(
      :weight => total_weight
    )
  end

  def build_shipment(from_address, to_address, parcel)
    shipment = ::EasyPost::Shipment.create(
      :to_address => to_address,
      :from_address => from_address,
      :parcel => parcel
    )
  end
end

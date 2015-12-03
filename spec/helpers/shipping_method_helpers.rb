module ShippingMethodHelpers
  FIXTURE_PARAMS = [
    {
      name:       "USPS First",
      display_on: :both,
      admin_name: "USPS First",
      code:       "First"
    },
    {
      name:       "USPS Priority",
      display_on: :both,
      admin_name: "USPS Priority",
      code:       "Priority"
    },
    {
      name:       "USPS ParcelSelect",
      display_on: :both,
      admin_name: "USPS ParcelSelect",
      code:       "ParcelSelect"
    },
    {
      name:       "USPS Express",
      display_on: :both,
      admin_name: "USPS Express",
      code:       "Express"
    }
  ]

  def create_shipping_methods
    shipping_category = create :shipping_category
    FIXTURE_PARAMS.each do |params|
      params.merge!(
        calculator: Spree::Calculator::Shipping::FlatRate.new,
        shipping_categories: [shipping_category]
      )
      Spree::ShippingMethod.create! params
    end
  end
end

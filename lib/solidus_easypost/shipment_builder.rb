# frozen_string_literal: true

module SolidusEasypost
  class ShipmentBuilder
    class << self
      def from_package(package)
        ::EasyPost::Shipment.create(
          to_address: AddressBuilder.from_address(package.order.ship_address),
          from_address: AddressBuilder.from_stock_location(package.stock_location),
          parcel: ParcelBuilder.from_package(package),
        )
      end

      def from_shipment(shipment)
        ::EasyPost::Shipment.create(
          to_address: AddressBuilder.from_address(shipment.order.ship_address),
          from_address: AddressBuilder.from_stock_location(shipment.stock_location),
          parcel: ParcelBuilder.from_package(shipment.to_package),
        )
      end

      def from_return_authorization(return_authorization)
        ::EasyPost::Shipment.create(
          from_address: AddressBuilder.from_stock_location(return_authorization.stock_location),
          to_address: AddressBuilder.from_address(return_authorization.order.ship_address),
          parcel: ParcelBuilder.from_return_authorization(return_authorization),
          is_return: true
        )
      end
    end
  end
end

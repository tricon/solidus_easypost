# frozen_string_literal: true

module SolidusEasypost
  class ParcelBuilder
    class << self
      def from_package(package)
        total_weight = package.contents.sum do |item|
          item.quantity * item.variant.weight
        end

        ::EasyPost::Parcel.create weight: total_weight
      end

      def from_return_authorization(return_authorization)
        total_weight = return_authorization.inventory_units.joins(:variant).sum(:weight)
        ::EasyPost::Parcel.create weight: total_weight
      end
    end
  end
end

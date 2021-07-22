# frozen_string_literal: true

module SolidusEasypost
  module Calculator
    class WeightDimensionCalculator < BaseDimensionCalculator
      protected

      def compute_for_return_authorization(return_authorization)
        total_weight = return_authorization.inventory_units.joins(:variant).sum(:weight)
        SolidusEasypost::ParcelDimension.new(weight: total_weight)
      end

      def compute_for_package(package)
        total_weight = package.contents.sum do |item|
          item.quantity * item.variant.weight
        end

        SolidusEasypost::ParcelDimension.new(weight: total_weight)
      end
    end
  end
end

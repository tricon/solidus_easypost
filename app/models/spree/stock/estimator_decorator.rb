# frozen_string_literal: true

module Spree
  module Stock
    module EstimatorDecorator
      def shipping_rates(package, frontend_only = true)
        SolidusEasypost::Estimator.new.shipping_rates(package, frontend_only)
      end
    end
  end
end

Spree::Stock::Estimator.prepend Spree::Stock::EstimatorDecorator

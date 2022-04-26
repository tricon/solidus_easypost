# frozen_string_literal: true

module SolidusEasypost
  module Calculator
    class BaseDimensionCalculator
      def compute(resource)
        case resource
        when ::SolidusEasypost::ReturnAuthorization
          compute_for_return_authorization(resource)
        when ::Spree::Stock::Package
          compute_for_package(resource)
        else
          raise SolidusEasypost::Errors::UnknownPartialResourceError
        end
      end

      protected

      def compute_for_return_authorization(return_authorization)
        raise NotImplementedError
      end

      def compute_for_package(package)
        raise NotImplementedError
      end
    end
  end
end

# frozen_string_literal: true

module SolidusEasypost
  module Errors
    class UnknownPartialResourceError < StandardError
      def message
        'The passed resource must be a Spree::ReturnAuthorization or a Spree::Stock::Package!'
      end
    end
  end
end

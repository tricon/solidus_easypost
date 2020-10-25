# frozen_string_literal: true

require 'solidus_core'
require 'solidus_support'
require 'deface'
require 'easypost'

require 'solidus_easypost/version'
require 'solidus_easypost/engine'
require 'solidus_easypost/configuration'
require 'solidus_easypost/address_builder'
require 'solidus_easypost/parcel_builder'
require 'solidus_easypost/shipment_builder'
require 'solidus_easypost/estimator'
require 'solidus_easypost/shipping_rate_calculator'
require 'solidus_easypost/shipping_method_selector'
require 'solidus_easypost/tracker_webhook_handler'

module SolidusEasypost
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end
  end
end

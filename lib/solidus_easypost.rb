# frozen_string_literal: true

require 'solidus_core'
require 'solidus_support'
require 'easypost'

require 'solidus_easypost/version'
require 'solidus_easypost/engine'
require 'solidus_easypost/configuration'

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

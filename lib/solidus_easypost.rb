# frozen_string_literal: true

require 'solidus_support'
require 'solidus_core'

module Solidus
  module EasyPost
    CONFIGS = { purchase_labels?: true } # rubocop:disable Style/MutableConstant
  end
end

require 'easypost'
require 'solidus_easypost/engine'

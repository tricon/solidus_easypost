# frozen_string_literal: true

require 'solidus_core'
require 'solidus_support'

module Solidus
  module EasyPost
    CONFIGS = { purchase_labels?: true } # rubocop:disable Style/MutableConstant
  end
end

require 'easypost'
require 'deface'
require 'solidus_easypost/version'
require 'solidus_easypost/engine'

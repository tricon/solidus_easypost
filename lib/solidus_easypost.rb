require 'solidus_support'
require 'solidus_core'

module Solidus
  module EasyPost
    CONFIGS = { purchase_labels?: true }
  end
end

require 'easypost'
require 'solidus_easypost/engine'

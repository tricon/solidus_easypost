# frozen_string_literal: true

module SolidusEasypost
  class Configuration
    attr_accessor :purchase_labels
    attr_writer :shipping_method_selector_class

    def initialize
      self.purchase_labels = true
    end

    def shipping_method_selector_class
      @shipping_method_selector_class ||= 'SolidusEasypost::ShippingMethodSelector'
      @shipping_method_selector_class.constantize
    end
  end
end

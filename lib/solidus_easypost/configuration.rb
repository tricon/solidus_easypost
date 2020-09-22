# frozen_string_literal: true

module SolidusEasypost
  class Configuration
    attr_accessor :purchase_labels

    def initialize
      self.purchase_labels = true
    end
  end
end

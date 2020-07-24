module SolidusEasypost
  class Configuration
    attr_reader :purchase_labels

    def initialize
      @purchase_labels = true
    end
  end
end

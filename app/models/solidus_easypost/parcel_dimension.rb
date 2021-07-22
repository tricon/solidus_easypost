# frozen_string_literal: true

module SolidusEasypost
  class ParcelDimension
    def initialize(**params)
      raise ArgumentError, 'The weight param is mandatory!' unless valid_value?(value: params[:weight])

      @weight = params[:weight]
      @width = params[:width]
      @height = params[:height]
      @depth = params[:depth]
    end

    def to_h
      hash = {
        weight: weight
      }

      hash[:width] = width if valid_value?(value: width)
      hash[:height] = height if valid_value?(value: height)
      hash[:length] = depth if valid_value?(value: depth)

      hash
    end

    private

    def valid_value?(value:)
      value.present? && !value.zero?
    end

    attr_reader :width, :height, :depth, :weight
  end
end

# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::ShippingRate do
  describe '#name' do
    context 'when the shipping rate has its own name' do
      it 'returns the name on the shipping rate' do
        shipping_rate = build_stubbed(:shipping_rate, name: 'USPS Express')

        expect(shipping_rate.name).to eq('USPS Express')
      end
    end

    context 'when the shipping rate does not have its own name' do
      it 'returns the name on the shipping method' do
        shipping_rate = build_stubbed(:shipping_rate, name: nil)

        expect(shipping_rate.name).to eq(shipping_rate.shipping_method.name)
      end
    end
  end
end

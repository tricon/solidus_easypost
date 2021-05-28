# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusEasypost::Estimator, vcr: { cassette_name: 'estimator' } do
  describe '#shipping_rates' do
    context 'when the shipping methods are available to users' do
      it 'returns the shipping rates' do
        stub_shipping_method_selector(available_to_users: true)

        rates = described_class.new.shipping_rates(create(:shipment).to_package)

        hash = {
          "USPS Express" => 22.74,
          "USPS First" => 3.82,
          "USPS ParcelSelect" => 6.85,
          "USPS Priority" => 6.95,
        }

        expect(rates.sort_by(&:name).map { |r| [r.name, r.cost] }.to_h).to eq(hash)
      end
    end

    context 'when the shipping methods are not available to users' do
      it 'returns no rates' do
        stub_shipping_method_selector(available_to_users: false)

        rates = described_class.new.shipping_rates(create(:shipment).to_package)

        expect(rates).to be_empty
      end
    end
  end

  private

  def stub_shipping_method_selector(available_to_users:)
    shipping_method_selector = Class.new.tap do |klass|
      klass.define_method(:shipping_method_for) do |rate|
        Spree::ShippingMethod.new(
          name: "#{rate.carrier} #{rate.service}",
          available_to_users: available_to_users,
        )
      end
    end

    stub_const('FakeShippingMethodSelector', shipping_method_selector)

    allow(SolidusEasypost.configuration).to receive(:shipping_method_selector_class)
      .and_return(FakeShippingMethodSelector)
  end
end

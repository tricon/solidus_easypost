# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Shipment do
  describe '#easypost_shipment' do
    context 'when no shipping rate was selected' do
      it 'returns nil' do
        shipment = create(:shipment)

        expect(shipment.easypost_shipment).to be_nil
      end
    end

    context 'when a shipping rate was selected' do
      it 'returns the shipment associated with the shipping rate' do
        easypost_shipment = stub_easypost_shipment
        shipment = create(
          :shipment,
          :with_easypost,
          easypost_shipment_id: easypost_shipment.id,
        )

        expect(shipment.easypost_shipment).to eq(easypost_shipment)
      end
    end
  end

  describe '#ship!' do
    context 'when purchase_labels is true' do
      it 'buys the selected rate' do
        stub_easypost_config(purchase_labels: true)
        easypost_shipment = stub_easypost_shipment
        selected_easypost_rate = easypost_shipment.rates.first

        shipment = create(
          :shipment,
          :with_easypost,
          state: 'ready',
          easypost_shipment_id: easypost_shipment.id,
          easypost_rate_id: selected_easypost_rate.id,
        )
        shipment.ship!

        expect(easypost_shipment).to have_received(:buy).with(selected_easypost_rate)
      end
    end

    context 'when purchase_labels is false' do
      it 'does not buy rates automatically' do
        stub_easypost_config(purchase_labels: false)
        easypost_shipment = stub_easypost_shipment
        selected_easypost_rate = easypost_shipment.rates.first

        shipment = create(
          :shipment,
          :with_easypost,
          state: 'ready',
          easypost_shipment_id: easypost_shipment.id,
          easypost_rate_id: selected_easypost_rate.id,
        )

        shipment.ship!

        expect(easypost_shipment).not_to have_received(:buy)
      end
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Shipment, :vcr do
  let!(:shipment) { order.shipments.first }
  let!(:order) do
    create(:order_with_line_items, line_items_count: 1, ship_address: to) do |order|
      order.variants.each { |v| v.update! weight: 10 }
    end
  end

  let(:to) do
    Spree::Address.create(
      firstname: 'Newt',
      lastname: 'Scamander',
      address1: '200 19th St',
      city: 'Birmingham',
      state: Spree::State.first || create(:state),
      country: Spree::Country.first || create(:country),
      zipcode: 35_203,
      phone: '123456789'
    )
  end

  before do
    create_shipping_methods
    shipment.stock_location.update(
      address1: '2630 Cahaba Rd',
      city: 'Birmingham',
      state: Spree::State.first,
      country: Spree::Country.first,
      zipcode: 35_223,
    )
  end

  it "'buys' a shipping rate after transitioning to ship" do
    shipment.refresh_rates
    shipment.state = 'ready'

    shipment.ship!
    expect(shipment.tracking).to be_present
  end

  describe '#easypost_shipment' do
    subject { shipment.easypost_shipment }

    shared_examples 'an easypost shipment' do
      it 'is an EasyPost::Shipment object' do
        expect(subject).to be_a(EasyPost::Shipment)
      end
    end

    context 'when it is a new shipment' do
      it_behaves_like 'an easypost shipment'

      it 'calls the api' do
        expect(EasyPost::Shipment).to receive(:create).with(anything)
        subject
      end
    end

    context 'when it is an existing shipment' do
      let(:new_shipment) { create :shipment }

      before do
        ep_id = shipment.easypost_shipment.id
        shipment.shipping_rates.first.update selected: true, easy_post_shipment_id: ep_id
        shipment.instance_variable_set('@ep_shipment', nil)
      end

      it_behaves_like 'an easypost shipment'

      it 'loads the existing shipment' do
        expect(EasyPost::Shipment).to receive(:retrieve).with(anything)
        subject
      end
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::StockLocation, :vcr do
  let(:stock_location) { create :stock_location }

  describe '#easypost_address' do
    subject { stock_location.easypost_address }

    it 'is an EasyPost::Address object' do
      expect(subject).to be_a(EasyPost::Address)
    end

    it 'has the correct attributes' do
      # combination of original address factory from easy post
      # and the spree_modification factories
      is_expected.to have_attributes(
        name: 'NY Warehouse',
        company: 'NY Warehouse',
        street1: '131 S 8th Ave',
        street2: nil,
        city: 'Manville',
        state: 'NJ',
        zip: '08835',
        country: 'US',
        phone: '2024561111'
      )
    end
  end
end

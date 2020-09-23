# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusEasypost::ReturnAuthorization, vcr: { cassette_name: 'return_authorization' } do
  let(:auth) { described_class.new return_authorization }
  let(:return_authorization) do
    create :return_authorization do |ra|
      ra.return_items << create(:return_item)
    end
  end

  before { create :shipping_method, admin_name: 'USPS Priority' }

  before { create :store }

  describe '#return_label' do
    it 'has the correct fields' do
      return_label = auth.return_label(auth.easypost_shipment.rates.first)
      expect(return_label).to have_attributes(object: 'PostageLabel')
    end
  end
end

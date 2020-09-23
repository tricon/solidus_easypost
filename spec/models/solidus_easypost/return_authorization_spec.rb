# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusEasypost::ReturnAuthorization, vcr: { cassette_name: 'return_authorization' } do
  describe '#return_label' do
    it 'returns a valid return label' do
      return_authorization = create(:return_item).return_authorization

      easypost_return_authorization = described_class.new(return_authorization)
      selected_easypost_rate = easypost_return_authorization.easypost_shipment.rates.first
      return_label = easypost_return_authorization.return_label(selected_easypost_rate)

      expect(return_label).to have_attributes(object: 'PostageLabel')
    end
  end
end

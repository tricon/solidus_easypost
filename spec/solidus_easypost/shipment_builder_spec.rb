# frozen_string_literal: true

RSpec.describe SolidusEasypost::ShipmentBuilder do
  describe '.from_package', vcr: { cassette_name: 'shipment_builder/from_package' } do
    it 'builds a shipment with the correct attributes' do
      shipment = described_class.from_package(create(:shipment).to_package)

      expect(shipment).to have_attributes(object: 'Shipment')
    end

    context 'with options', vcr: { cassette_name: 'shipment_builder/from_package_with_options' } do
      it 'allow options for shipment' do
        message = 'an instruction'
        shipment = described_class.from_package(create(:shipment).to_package, { handling_instructions: message })
        expect(shipment.options).to have_attributes(handling_instructions: message.upcase)
      end
    end

    context 'with options', vcr: { cassette_name: 'shipment_builder/from_package_with_address_options' } do
      it 'allow address options' do
        address_opts = { residential: false }
        shipment = described_class.from_package(create(:shipment).to_package, { from_address_options: address_opts })
        expect(shipment.from_address).to have_attributes(residential: false)
      end
    end
  end

  describe '.from_shipment', vcr: { cassette_name: 'shipment_builder/from_shipment' } do
    it 'builds a shipment with the correct attributes' do
      shipment = described_class.from_shipment(create(:shipment))

      expect(shipment).to have_attributes(object: 'Shipment')
    end
  end

  describe '.from_return_authorization', vcr: { cassette_name: 'shipment_builder/from_return_authorization' } do
    it 'builds a shipment with the correct attributes' do
      solidus_return_authorization = create(:return_item).return_authorization
      shipment = described_class.from_return_authorization(SolidusEasypost::ReturnAuthorization.new(solidus_return_authorization))

      expect(shipment).to have_attributes(object: 'Shipment')
    end
  end
end

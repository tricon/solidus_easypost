RSpec.describe SolidusEasypost::ShipmentBuilder, vcr: { cassette_name: 'shipment_builder' } do
  describe '.from_package' do
    it 'builds a shipment with the correct attributes' do
      shipment = described_class.from_package(create(:shipment).to_package)

      expect(shipment).to have_attributes(object: 'Shipment')
    end
  end

  describe '.from_shipment' do
    it 'builds a shipment with the correct attributes' do
      shipment = described_class.from_shipment(create(:shipment))

      expect(shipment).to have_attributes(object: 'Shipment')
    end
  end

  describe '.from_return_authorization' do
    it 'builds a shipment with the correct attributes' do
      shipment = described_class.from_return_authorization(create(:return_authorization))

      expect(shipment).to have_attributes(object: 'Shipment')
    end
  end
end

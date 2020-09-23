RSpec.describe SolidusEasypost::ParcelBuilder do
  describe '.from_package', vcr: { cassette_name: 'parcel_builder/from_package' } do
    it 'builds a parcel with the correct attributes' do
      parcel = described_class.from_package(create(:shipment).to_package)

      expect(parcel).to have_attributes(object: 'Parcel')
    end
  end

  describe '.from_return_authorization', vcr: { cassette_name: 'parcel_builder/from_return_authorization' } do
    it 'builds a parcel with the correct attributes' do
      shipment = described_class.from_return_authorization(create(:return_item).return_authorization)

      expect(shipment).to have_attributes(object: 'Parcel')
    end
  end
end

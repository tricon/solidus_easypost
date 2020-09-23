RSpec.describe SolidusEasypost::AddressBuilder, vcr: { cassette_name: 'address_builder' } do
  describe '.from_address' do
    it 'builds an address with the correct attributes' do
      address = described_class.from_address(build_stubbed(:address))

      expect(address).to have_attributes(object: 'Address')
    end
  end

  describe '.from_stock_location' do
    it 'builds an address with the correct attributes' do
      address = described_class.from_stock_location(create(:stock_location))

      expect(address).to have_attributes(object: 'Address')
    end
  end
end

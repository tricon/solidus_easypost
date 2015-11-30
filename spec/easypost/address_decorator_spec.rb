require 'spec_helper'

RSpec.describe Spree::Address do
  let(:address) { create :address }

  describe '#easypost_address' do
    subject { address.easypost_address }

    it { is_expected.to be_a EasyPost::Address }

    it do
      is_expected.to have_attributes(
        name: 'John Doe',
        company: 'Company',
        street1: '10 Lovely Street',
        street2: 'Northwest',
        city: 'Herndon',
        state: 'AL',
        zip: '35005',
        country: 'US',
        phone: '5555550199'
      )
    end
  end
end

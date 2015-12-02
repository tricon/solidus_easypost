require 'spec_helper'

RSpec.describe Spree::ShippingRate, :vcr do
  let(:rate) { described_class.new name: name }
  let(:name) { 'SuperAwesomeCool' }


  describe '#name' do
    subject { rate.name }
    it { is_expected.to eq name }
  end
end

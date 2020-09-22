# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusEasypost::ReturnAuthorization, :vcr do
  let(:auth) { described_class.new return_authorization }
  let(:return_authorization) do
    create :return_authorization do |ra|
      ra.return_items << create(:return_item)
    end
  end

  before { create :shipping_method, admin_name: 'USPS Priority' }

  before { create :store }

  describe '#easypost_shipment' do
    subject { auth.easypost_shipment }

    it 'is an EasyPost::Shipment object' do
      expect(subject).to be_a(EasyPost::Shipment)
    end
  end

  describe '#return_label' do
    subject { auth.return_label shipment.rates.first }

    let(:shipment) { auth.easypost_shipment }

    it 'is an EasyPost::PackageLabel object' do
      expect(subject).to be_a(EasyPost::PostageLabel)
    end

    it 'has the correct fields' do
      expect(subject).to have_attributes(
        id: "pl_37f765f275dd46c2866d0515694a306c",
        object: "PostageLabel",
        created_at: "2019-11-12T08:36:50Z",
        updated_at: "2019-11-12T08:36:51Z",
        date_advance: 0,
        integrated_form: "none",
        label_date: "2019-11-12T08:36:50Z",
        label_resolution: 300,
        label_size: "4x6",
        label_type: "default",
        label_url: "https://easypost-files.s3-us-west-2.amazonaws.com/files/postage_label/20191112/ebe045d367a742dd8bf718e63a58c390.png",
        label_file_type: "image/png"
      )
    end
  end
end

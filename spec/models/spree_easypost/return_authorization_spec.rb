require 'spec_helper'

RSpec.describe Spree::EasyPost::ReturnAuthorization, :vcr do
  let(:auth) { described_class.new return_authorization }
  let(:return_authorization) do
    create :return_authorization  do |ra|
      ra.return_items << create(:return_item)
    end
  end
  let!(:shipping_method) { create :shipping_method, admin_name: 'USPS Priority' }

  before { create :store }

  describe '#easypost_shipment' do
    subject { auth.easypost_shipment }
    it { is_expected.to be_a EasyPost::Shipment }
  end

  describe '#return_label' do
    subject { auth.return_label shipment.rates.first }
    let(:shipment) { auth.easypost_shipment }

    it { is_expected.to be_a EasyPost::PostageLabel }
    it 'has the correct fields' do
      expect(subject).to have_attributes(
         id: "pl_f7df665bb66b465f92da8e8b74d633aa",
         object: "PostageLabel",
         created_at: "2018-12-18T15:40:25Z",
         updated_at: "2018-12-18T15:40:26Z",
         date_advance: 0,
         integrated_form: "none",
         label_date: "2018-12-18T15:40:25Z",
         label_resolution: 300,
         label_size: "4x6",
         label_type: "default",
         label_url: "https://easypost-files.s3-us-west-2.amazonaws.com/files/postage_label/20181218/9d05da1a2184484cba814a3db2923293.png",
         label_file_type: "image/png"
      )
    end
  end
end

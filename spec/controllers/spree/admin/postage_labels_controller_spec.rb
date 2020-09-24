RSpec.describe Spree::Admin::PostageLabelsController do
  stub_authorization!

  describe "GET #show" do
    it 'redirects to the postage label', vcr: { cassette_name: 'postage_labels/show' } do
      order = create(:shipped_order) do |o|
        o.shipments.first.selected_shipping_rate.update!(
          easy_post_rate_id: 'rate_3de1727d77d74f1a8b1bf95fcd89e1ee',
          easy_post_shipment_id: 'shp_5113aed5b7494a2b85b43960f1bb26c0',
        )
      end

      get :show, params: { shipment_id: order.shipments.first.number }

      expect(response).to redirect_to('https://easypost-files.s3-us-west-2.amazonaws.com/files/postage_label/20200924/4bff5f82521649e0b65f019fabe46e02.png')
    end
  end
end

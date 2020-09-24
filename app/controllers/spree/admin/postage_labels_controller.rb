# frozen_string_literal: true

module Spree
  module Admin
    class PostageLabelsController < Spree::Admin::BaseController
      def show
        @shipment = Spree::Shipment.find_by(number: params[:shipment_id])
        authorize! @shipment, :show

        unless @shipment.easypost_postage_label_url
          flash[:error] = t('.no_postage_label', shipment_number: @shipment.number)
          redirect_back(fallback_location: edit_admin_order_path(@shipment.order))
          return
        end

        redirect_to @shipment.easypost_postage_label_url
      end
    end
  end
end

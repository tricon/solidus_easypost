# frozen_string_literal: true

module SolidusEasypost
  module Spree
    module CartonDecorator
      def easypost_tracker
        return @easypost_tracker if @easypost_tracker

        if easy_post_tracker_id.present?
          @easypost_tracker = EasyPost::Tracker.retrieve(easy_post_tracker_id)
        else
          @easypost_tracker = EasyPost::Tracker.create(
            tracking_code: tracking,
            carrier: shipping_method.carrier,
          )

          update!(easy_post_tracker_id: @easypost_tracker.id)
        end

        @easypost_tracker
      end

      ::Spree::Carton.prepend self
    end
  end
end

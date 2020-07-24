# frozen_string_literal: true

module SolidusEasypost
  module Spree
    module AddressDecorator
      def easypost_address
        attributes = {
          street1: address1,
          street2: address2,
          city: city,
          zip: zipcode,
          phone: phone
        }

        attributes[:company] = company if respond_to?(:company)
        attributes[:name] = if respond_to?(:name)
          name
        elsif respond_to?(:full_name)
          full_name
        end
        attributes[:state] = state ? state.abbr : state_name
        attributes[:country] = country&.iso

        ::EasyPost::Address.create attributes
      end

      ::Spree::Address.prepend self
    end
  end
end

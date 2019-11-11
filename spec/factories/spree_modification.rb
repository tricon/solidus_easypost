# frozen_string_literal: true

require 'spree/testing_support/factories'
require 'solidus_easypost/factories'

FactoryBot.modify do
  factory :shipping_method do
    admin_name { 'Stuff' }
    available_to_users { true }
  end

  factory :stock_location do
    address1 { '131 S 8th Ave' }
    city { 'Manville' }
    association(:state, name: 'New Jersey', abbr: 'NJ')
    zipcode { '08835' }
  end

  factory :address do
    address1 { '215 N 7th Ave' }
    city { 'Manville' }
    association(:state, name: 'New Jersey', abbr: 'NJ')
    zipcode { '08835' }
  end
end

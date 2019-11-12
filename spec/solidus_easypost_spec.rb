# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Solidus::EasyPost do
  describe 'CONFIGS' do
    it 'can be altered' do
      expect {
        Solidus::EasyPost::CONFIGS[:purchase_labels?] = false
      }.to change { Solidus::EasyPost::CONFIGS[:purchase_labels?] }.to(false)
    end
  end
end

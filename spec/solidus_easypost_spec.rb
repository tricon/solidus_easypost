# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusEasypost do
  describe 'CONFIGS' do
    it 'can be altered' do
      expect {
        SolidusEasypost::CONFIGS[:purchase_labels?] = false
      }.to change { SolidusEasypost::CONFIGS[:purchase_labels?] }.to(false)
    end
  end
end

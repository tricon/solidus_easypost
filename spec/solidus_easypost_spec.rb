# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusEasypost do
  describe '.configuration' do
    it 'returns the configuration' do
      expect(described_class.configuration).to be_instance_of(SolidusEasypost::Configuration)
    end
  end

  describe '.configure' do
    it 'yields the configuration' do
      expect { |b| described_class.configure(&b) }.to yield_with_args(
        an_instance_of(SolidusEasypost::Configuration),
      )
    end
  end
end

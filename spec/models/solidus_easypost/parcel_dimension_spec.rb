# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusEasypost::ParcelDimension do
  describe '.new' do
    subject(:instance) { described_class.new(params) }

    let(:params) do
      { height: 3 }
    end

    context 'when the weight is not passed' do
      let(:params) do
        { height: 3 }
      end

      it 'raises an argument error exception' do
        expect {
          instance
        }.to raise_error(ArgumentError)
      end
    end

    context 'when the passed weight is zero' do
      let(:params) do
        { height: 3, weight: 0 }
      end

      it 'raises an argument error exception' do
        expect {
          instance
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#to_h' do
    subject(:instance_hash) { described_class.new(params).to_h }

    context 'when the params contains zero values' do
      let(:params) do
        { weight: 3, width: 0, height: 0, unknown: -1 }
      end

      it 'returns the correct parcel dimension hash' do
        expect(instance_hash).to eq({
          weight: 3
        })
      end
    end

    context 'when the params contains the wrong params' do
      let(:params) do
        { weight: 3, unknown: -1, another: 11 }
      end

      it 'returns the correct parcel dimension hash' do
        expect(instance_hash).to eq({
          weight: 3
        })
      end
    end

    context 'when the params contains the correct params' do
      let(:params) do
        { weight: 3, width: 1, depth: 6, height: 11 }
      end

      it 'returns the correct parcel dimension hash' do
        expect(instance_hash).to eq({
          height: 11,
          weight: 3,
          width: 1,
          length: 6,
        })
      end
    end
  end
end

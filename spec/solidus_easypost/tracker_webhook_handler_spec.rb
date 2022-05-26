# frozen_string_literal: true

require "spec_helper"

RSpec.describe SolidusEasypost::TrackerWebhookHandler do
  describe '.call' do
    context 'when the event is not tracker.updated' do
      it 'does not process the event' do
        stub_const('SolidusSupport::LegacyEventCompat::Bus', class_spy(SolidusSupport::LegacyEventCompat::Bus))
        create(:carton, easy_post_tracker_id: 'trk_test')

        payload = {
          'description' => 'tracker.created',
          'result' => {
            'id' => 'trk_test',
          },
        }
        described_class.call(payload)

        expect(SolidusSupport::LegacyEventCompat::Bus).not_to have_received(:publish)
      end
    end

    context 'when the tracker was not registered in Solidus' do
      it 'does not process the event' do
        stub_const('SolidusSupport::LegacyEventCompat::Bus', class_spy(SolidusSupport::LegacyEventCompat::Bus))
        create(:carton, easy_post_tracker_id: 'trk_test')

        payload = {
          'description' => 'tracker.updated',
          'result' => {
            'id' => 'trk_test1',
          },
        }
        described_class.call(payload)

        expect(SolidusSupport::LegacyEventCompat::Bus).not_to have_received(:publish)
      end
    end

    context 'when the event is a tracker update for a registered tracker' do
      it 'forwards the event via the event bus' do
        stub_const('SolidusSupport::LegacyEventCompat::Bus', class_spy(SolidusSupport::LegacyEventCompat::Bus))
        carton = create(:carton, easy_post_tracker_id: 'trk_test')

        payload = {
          'description' => 'tracker.updated',
          'result' => {
            'id' => 'trk_test',
          },
        }
        described_class.call(payload)

        expect(SolidusSupport::LegacyEventCompat::Bus).to have_received(:publish).with(
          :'solidus_easypost.tracker.updated',
          carton: carton,
          payload: payload,
        )
      end
    end
  end
end

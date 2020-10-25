RSpec.describe SolidusEasypost::TrackerWebhookHandler do
  describe '.call' do
    context 'when the event is not tracker.updated' do
      it 'does not process the event' do
        stub_const('Spree::Event', class_spy(Spree::Event))
        create(:carton, easy_post_tracker_id: 'trk_test')

        payload = {
          'description' => 'tracker.created',
          'result' => {
            'id' => 'trk_test',
          },
        }
        described_class.call(payload)

        expect(Spree::Event).not_to have_received(:fire)
      end
    end

    context 'when the tracker was not registered in Solidus' do
      it 'does not process the event' do
        stub_const('Spree::Event', class_spy(Spree::Event))
        create(:carton, easy_post_tracker_id: 'trk_test')

        payload = {
          'description' => 'tracker.updated',
          'result' => {
            'id' => 'trk_test1',
          },
        }
        described_class.call(payload)

        expect(Spree::Event).not_to have_received(:fire)
      end
    end

    context 'when the event is a tracker update for a registered tracker' do
      it 'forwards the event via the event bus' do
        stub_const('Spree::Event', class_spy(Spree::Event))
        carton = create(:carton, easy_post_tracker_id: 'trk_test')

        payload = {
          'description' => 'tracker.updated',
          'result' => {
            'id' => 'trk_test',
          },
        }
        described_class.call(payload)

        expect(Spree::Event).to have_received(:fire).with(
          'solidus_easypost.tracker.updated',
          carton: carton,
          payload: payload,
        )
      end
    end
  end
end

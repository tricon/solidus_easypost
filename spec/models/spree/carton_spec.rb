RSpec.describe Spree::Carton do
  describe '#easypost_tracker' do
    context 'when a tracker was already created' do
      it 'returns the existing tracker' do
        carton = create(:carton, easy_post_tracker_id: 'trk_test')
        tracker = instance_double(EasyPost::Tracker)
        allow(EasyPost::Tracker).to receive(:retrieve).with('trk_test').and_return(tracker)

        expect(carton.easypost_tracker).to eq(tracker)
      end
    end

    context 'when a tracker was not created' do
      it 'creates a new tracker' do
        carton = create(:carton, tracking: 'TESTTRACKING', shipping_method: create(:shipping_method, carrier: 'FedEx'))
        tracker = instance_double(EasyPost::Tracker, id: 'trk_test')
        allow(EasyPost::Tracker).to receive(:create).with(tracking_code: 'TESTTRACKING', carrier: 'FedEx').and_return(tracker)

        expect(carton.easypost_tracker).to eq(tracker)
      end

      it "sets the tracker's ID on the carton" do
        carton = create(:carton)
        tracker = instance_double(EasyPost::Tracker, id: 'trk_test')
        allow(EasyPost::Tracker).to receive(:create).and_return(tracker)

        carton.easypost_tracker

        expect(carton.easy_post_tracker_id).to eq('trk_test')
      end
    end
  end
end

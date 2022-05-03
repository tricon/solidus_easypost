RSpec.describe Spree::Carton do
  describe '.create' do
    context 'when track_all_cartons is true' do
      it 'tracks the package automatically' do
        stub_easypost_config(track_all_cartons: true)
        tracker = instance_double(EasyPost::Tracker, id: 'trk_test')
        allow(EasyPost::Tracker).to receive(:create).and_return(tracker)

        carton = create(:carton)

        expect(carton.easy_post_tracker_id).to eq('trk_test')
      end
    end

    context 'when track_all_cartons is false' do
      it 'does not track all packages automatically' do
        stub_easypost_config(track_all_cartons: false)

        carton = create(:carton)

        expect(carton.easy_post_tracker_id).to be_nil
      end
    end
  end

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

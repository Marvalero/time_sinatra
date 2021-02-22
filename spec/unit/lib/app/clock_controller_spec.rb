
RSpec.describe Clock::Controller, :db do
  let(:controller) { described_class.new(collection, factory) }
  let(:factory) { double(Clock::Entity)}
  let(:collection) { instance_double(Clock::Collection) }
  let(:clock) do
    {
      'name' => 'hermione',
      'time' => 'potion class time',
      'count' => 4,
    }
  end

  describe '#find' do
    context 'when successful' do
      let(:object) { OpenStruct.new() }
      let(:result_success) { OpenStruct.new(success?: true, object: object) }
      before do
        expect(collection).to receive(:find_by_name)
          .with("fooname").and_return(result_success)
      end

      it 'calls the collection with the clock' do
        result = controller.find(name: "fooname")
        expect(result.success?).to be(true)
        expect(result.object).to be(object)
      end
    end
    context 'when no object' do
      let(:result_no_object) { OpenStruct.new(success?: true, object: nil) }
      let(:clock) { OpenStruct.new() }
      before do
        expect(collection).to receive(:find_by_name)
          .with("fooname").and_return(result_no_object)
        expect(factory).to receive(:current)
          .with("fooname").and_return(clock)
      end

      it 'calls the collection with the clock' do
        result = controller.find(name: "fooname")
        expect(result.success?).to be(true)
        expect(result.object).to be(clock)
      end
    end
  end

  describe '#record' do
    context 'when no errors' do
      let(:result_success) { OpenStruct.new(success?: true) }
      before do
        expect(collection).to receive(:create)
          .with(clock).and_return(result_success)
      end

      it 'calls the collection with the clock' do
        result = controller.record(clock)
        expect(result.success?).to be(true)
      end
    end
    context 'when errors' do
      let(:result_fail) { OpenStruct.new(success?: false) }
      before do
        expect(collection).to receive(:create)
          .with(clock).and_return(result_fail)
      end

      it 'rejects the clock as invalid' do
        clock.delete('time')
        result = controller.record(clock)

        expect(result.success?).to be(false)
      end
    end
  end
end


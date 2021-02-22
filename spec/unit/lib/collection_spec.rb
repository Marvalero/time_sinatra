RSpec.describe Clock::Collection do
  let(:collection) { described_class.new(database, factory) }
  let(:factory) { double(Clock::Entity) }
  let(:record) { instance_double(Clock::RecordResult) }
  let(:clock) { instance_double(Clock::Entity) }
  let(:database) { double(Clock::Database) }

  describe '#create' do
    it 'stores the clock' do
      expect(clock).to receive(:time).and_return("foo")
      expect(clock).to receive(:name).and_return("var")
      expect(database).to receive(:store_clock).with({name: "var", time: "foo"}).and_return(true)
      collection.create(clock)
    end
  end
  describe '#find_by_name' do
    it 'retrieves the clock' do
      expect(factory)
        .to receive(:new).with(superman: 1)
        .and_return(clock)
      expect(database)
        .to receive(:find_by_name).with("r2d2")
        .and_return(record)
      expect(record)
        .to receive(:object)
        .and_return({superman: 1})
      expect(record)
        .to receive(:object=)
      collection.find_by_name('r2d2')
    end
  end
end

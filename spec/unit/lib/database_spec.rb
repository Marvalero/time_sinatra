RSpec.describe Clock::Database do
  let(:database) { described_class }

  describe '.find_by_name' do
    context "when clock exists" do
      it "returns the clock" do
        database.store_clock({ name: 'r2d2', time: 'long time ago' })
        expect(database.find_by_name('r2d2').object).to eq({name: 'r2d2', time: 'long time ago'})
      end
    end
    context "when clock does not exist" do
      it "returns the clock" do
        expect(database.find_by_name('Oz').object).to eq(nil)
      end
    end
  end

  describe ".store_clock" do
    context "when clock exists" do
      it "returns the clock" do
        database.store_clock({ name: 'r2d2', time: 'long time ago' })
        expect(database.find_by_name('r2d2').object).to eq({name: 'r2d2', time: 'long time ago'})
      end
    end
  end
end

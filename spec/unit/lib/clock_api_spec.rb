require_relative '../../../lib/clock_api'
require 'rack/test'
RSpec.describe ClockApi do
  include Rack::Test::Methods
  let(:db_record) { Struct.new(:success?, :id, :error_message) }

  let(:controller) { instance_double('Controller::ClockCotroller') }

  def app
    ClockApi.new(controller)
  end


  describe 'POST /clocks/name' do
    context 'when the clock is successfully created' do
      let(:params) { { 'time' => 'bla', 'count' => 3 } }
      it 'returns 200 and clock id' do
        allow(controller).to receive(:record)
          .with(params)
          .and_return(db_record.new(true, 56, nil))

        post '/clocks/leek', JSON.generate(params)

        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)).to include('expense_id' => 56)
      end
    end
    context 'when the clock fails validation' do
      let(:params) { { 'time' => 'bla', 'count' => 3 } }
      it 'returns 422 and error message' do
        allow(controller).to receive(:record)
          .with(params)
          .and_return(db_record.new(false, 0, 'Incorrect count'))

        post '/clocks/leek', JSON.generate(params)

        expect(last_response.status).to eq(422)
        expect(JSON.parse(last_response.body).keys).to include('error')
      end
    end
  end
end

require_relative '../../../lib/clock_api'
require 'rack/test'
RSpec.describe ClockApi do
  include Rack::Test::Methods
  let(:db_record) { Clock::RecordResult }

  let(:controller) { instance_double(Clock::ClockController) }

  def app
    ClockApi.new(controller)
  end

  def response_body
    JSON.parse(last_response.body)
  end

  describe 'GET /clocks/:name' do
    context 'when clock exists' do
      before do
        allow(controller).to receive(:find)
          .with(name: "percy")
          .and_return(db_record.new(true, 56, nil, Clock::Clock.new("food time")))
      end
      it 'returns the expense records as JSON' do
        get '/clocks/percy'
        expect(response_body['time']).to eq("food time")
      end
      it 'responds with a 200 (OK)' do
        get '/clocks/percy'
        expect(last_response.status).to eq(200)
      end
    end
    context 'when there are no expenses on the given date' do
      it 'returns an empty array as JSON'
      it 'responds with a 200 (OK)'
    end
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

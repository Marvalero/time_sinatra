require 'rack/test'
RSpec.describe Clock::Api do
  include Rack::Test::Methods
  let(:db_record) { Clock::RecordResult }

  let(:controller) { instance_double(Clock::Controller) }

  def app
    described_class.new(controller)
  end

  def response_body
    JSON.parse(last_response.body)
  end

  describe 'GET /clocks/:name' do
    let(:object) {OpenStruct.new(time: "food time")}
    context 'when clock exists' do
      before do
        allow(controller).to receive(:find)
          .with(name: "percy")
          .and_return(db_record.new(true, 56, nil, object))
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
    context 'when there is an error' do
      before do
        allow(controller).to receive(:find)
          .with(name: "percy")
          .and_return(db_record.new(false, nil, "an error", nil))
      end
      it 'responds with a 500 (Internal Server Error)' do
        get '/clocks/percy'
        expect(last_response.status).to eq(500)
      end
    end
  end

  describe 'POST /clocks/name' do
    context 'when the clock is successfully created' do
      let(:params) { { 'time' => 'bla', 'count' => 3 } }
      it 'returns 200 and clock id' do
        allow(controller).to receive(:record)
          .with(params)
          .and_return(db_record.new(true, 56, nil, nil))

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
          .and_return(db_record.new(false, 0, 'Incorrect count', nil))

        post '/clocks/leek', JSON.generate(params)

        expect(last_response.status).to eq(422)
      end
    end
  end
end

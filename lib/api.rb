require 'json'

module Clock
  class Api < Sinatra::Base
    def initialize(controller)
      @clock_controller = controller
      super()
    end

    before do
      content_type :txt
    end

    get '/' do
      "#{Time.now.to_i}"
    end

    get '/clocks/:name' do
      result = @clock_controller.find(name: params[:name])
      if !result.success? then status 500 and return end
      status 200
      { 'time' => result.object.time }.to_json
    end

    post '/clocks/:name' do
      params = JSON.parse(request.body.read)
      result = @clock_controller.record(params)
      if !result.success? then status 422 and return JSON.generate('error' => result.error_message) end
      JSON.generate('expense_id' => result.id)
    end
  end
end

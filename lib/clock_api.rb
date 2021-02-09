require 'json'

class ClockApi < Sinatra::Base
  def initialize(controller = ClockController.new)
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
    clock_name = params[:name].to_sym
    "#{Time.now.to_i}"
  end

  post '/clocks/:name' do
    params = JSON.parse(request.body.read)
    result = @clock_controller.record(params)
    if !result.success? then status 422 and return JSON.generate('error' => result.error_message) end
    JSON.generate('expense_id' => result.id)
  end
end

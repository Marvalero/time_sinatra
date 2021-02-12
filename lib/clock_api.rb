require 'json'
require_relative './clock_controller'

class ClockApi < Sinatra::Base
  def initialize(controller = Clock::ClockController.new)
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
    JSON.generate('time' => result.object.time)
  end

  post '/clocks/:name' do
    params = JSON.parse(request.body.read)
    result = @clock_controller.record(params)
    if !result.success? then status 422 and return JSON.generate('error' => result.error_message) end
    JSON.generate('expense_id' => result.id)
  end
end

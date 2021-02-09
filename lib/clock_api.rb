require 'json'

class ClockApi < Sinatra::Base
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
    JSON.generate('expense_id' => 42)
  end
end

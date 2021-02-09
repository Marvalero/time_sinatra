require 'rack/test'
require 'spec_helper'

RSpec.describe ClockApi, type: :controller do
  include Rack::Test::Methods
  def app
    ClockApi
  end

  describe "Get /clocks" do
    context "no clocks" do
      it "returns current time" do
        get "/"
        expect(last_response.status).to eq(200)
        expect(last_response.body).to eq(Time.now.to_i.to_s)
      end
    end
    context "A clock" do
      before do
        @clocks = [{name: "r2d2", time: "long long time ago", count: 10}]
        $db = @clocks
      end
      it "returns the faked time" do
        get "/clocks/r2d2"
        expect(last_response.status).to eq(200)
        expect(last_response.body).to eq("long long time ago")
      end
    end
  end
  describe "Post /clocks" do
    context "with time" do
      it "returns 200" do
        post "/clocks/peak", time: "peak", count: 2 
        expect(last_response.status).to eq(200)
      end
    end
  end
end

require 'rack/test'
require 'spec_helper'
require 'json'

RSpec.describe ClockApi, type: :controller do
  include Rack::Test::Methods
  def app
    ClockApi
  end

  def post_clock(name, params)
    post "/clocks/#{name}", JSON.generate(params)
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body)).to include('expense_id' => a_kind_of(Integer))
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
        pending "need to add a db"
        post_clock("r2d2", {time: "long long time ago", count: 1})
        get "/clocks/r2d2"
        expect(last_response.status).to eq(200)
        expect(last_response.body).to eq("long long time ago")
      end
    end
  end
  describe "Post /clocks" do
    context "with time" do
      it "returns 200" do
        post_clock("peak", {time: "peak", count: 2})
      end
    end
  end

  describe "Get /undefined-route" do
    it "returns 404" do
      get "/undefined-route"
      expect(last_response.status).to eq(404)
    end
  end
end

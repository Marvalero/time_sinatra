require 'rack/test'
require 'spec_helper'
require 'json'

RSpec.describe Clock::Api, type: :controller do
  let(:database) { Clock::Database }
  include Rack::Test::Methods
  def app
    Clock::Box.new.api
  end

  def post_clock(name, params)
    post "/clocks/#{name}", JSON.generate(params)
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body)).to include('id' => a_kind_of(Integer))
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
        clock = {name: "r2d2", time: "long long time ago", count: 10}
        database.store_clock(clock)
      end
      it "returns the faked time" do
        post_clock("r2d2", {'time' => "long long time ago", 'count' => 1})
        get "/clocks/r2d2"
        expect(last_response.status).to eq(200)
        expect(last_response.body).to eq("{\"time\":\"long long time ago\"}")
      end
    end
  end
  describe "Post /clocks" do
    context "with time" do
      it "returns 200" do
        post_clock("peak", {"time" => "peak", 'count' => 2})
        expect(last_response.status).to eq(200)
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

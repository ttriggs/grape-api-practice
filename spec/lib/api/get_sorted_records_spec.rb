require 'spec_helper'

describe GrapeApp::API do
  include Rack::Test::Methods
  let(:redis) { Redis.new }
  let(:comma_file) { Document.new('./spec/example_seeds/comma_delimiter.txt') }
  let(:expected_header) do
    { "Content-Type" => "application/json",
      "Content-Length" => "440" }
  end
  before(:each) do
    redis.flushdb
    comma_file.import_records_to_db
  end

  def app
    GrapeApp::API
  end

  context "GET /records/gender" do
    it "returns json of records sorted by gender, then last name" do
      get "/records/gender"

      first_record = "[{\"last_name\":\"Apple\",\"first_name\":\"Julia\",\"gender\":\"female\",\"favorite_color\":\"blue\",\"display_dob\":\"6/10/1984\"}"
      last_record  = "{\"last_name\":\"Stevens\",\"first_name\":\"Steve\",\"gender\":\"male\",\"favorite_color\":\"red\",\"display_dob\":\"3/10/1983\"}]"

      expect(last_response.status).to be(200)
      expect(last_response.body).to start_with(first_record)
      expect(last_response.body).to end_with(last_record)
      expect(last_response.header).to include(expected_header)
    end
  end

  context "GET /records/birthdate" do
    it "returns json of records sorted by birthdate" do
      get "/records/birthdate"

      first_record = "[{\"last_name\":\"Stevens\",\"first_name\":\"Steve\",\"gender\":\"male\",\"favorite_color\":\"red\",\"display_dob\":\"3/10/1983\"}"
      last_record  = "{\"last_name\":\"Lee\",\"first_name\":\"Julia\",\"gender\":\"female\",\"favorite_color\":\"blue\",\"display_dob\":\"6/19/1984\"}]"

      expect(last_response.status).to be(200)
      expect(last_response.body).to start_with(first_record)
      expect(last_response.body).to end_with(last_record)
      expect(last_response.header).to include(expected_header)
    end
  end

  context "GET /records/name" do
    it "returns json of records sorted by last name" do
      get "/records/name"

      first_record = "[{\"last_name\":\"Stevens\",\"first_name\":\"Steve\",\"gender\":\"male\",\"favorite_color\":\"red\",\"display_dob\":\"3/10/1983\"}"
      last_record  = "{\"last_name\":\"Albert\",\"first_name\":\"Steve\",\"gender\":\"male\",\"favorite_color\":\"red\",\"display_dob\":\"3/19/1983\"}]"

      expect(last_response.status).to be(200)
      expect(last_response.body).to start_with(first_record)
      expect(last_response.body).to end_with(last_record)
      expect(last_response.header).to include(expected_header)
    end
  end
end

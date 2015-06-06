require 'spec_helper'

describe GrapeApp::API do
  include Rack::Test::Methods

  let(:redis) { Redis.new }
  before(:each) { redis.flushdb }
  let(:pipe_record)  { {"record" => "Stevens|Steve|male|red|19801210"}.to_json }
  let(:comma_record) { {"record" => "Stevens,Steve,male,red,19801210"}.to_json }
  let(:space_record) { {"record" => "Stevens Steve male red 19801210"}.to_json }
  let(:content_type) { {'CONTENT_TYPE' => 'application/json'} }

  def app
    GrapeApp::API
  end

  context "POST /records/ with pipe delimited record" do
    it "imports the new record to the db" do
      post "/records", pipe_record, content_type
      parsed_body = JSON.parse(last_response.body)

      expect(last_response.status).to eq(201)
      expect(parsed_body.length).to eq(1)
      expect(last_response.body).to include("\"last_name\":\"Stevens\",\"first_name\":\"Steve")
      expect(last_response.body).to include("display_dob\":\"12/10/1980\"")
    end
  end

  context "POST /records/ with comma delimited record" do
    it "imports the new record to the db" do
      post "/records", comma_record, content_type
      parsed_body = JSON.parse(last_response.body)

      expect(last_response.status).to eq(201)
      expect(parsed_body.length).to eq(1)
      expect(last_response.body).to include("\"last_name\":\"Stevens\",\"first_name\":\"Steve")
      expect(last_response.body).to include("display_dob\":\"12/10/1980\"")
    end
  end

  context "POST /records/ with space delimited record" do
    it "imports the new record to the db" do
      post "/records", space_record, content_type
      parsed_body = JSON.parse(last_response.body)

      expect(last_response.status).to eq(201)
      expect(parsed_body.length).to eq(1)
      expect(last_response.body).to include("\"last_name\":\"Stevens\",\"first_name\":\"Steve")
      expect(last_response.body).to include("display_dob\":\"12/10/1980\"")
    end
  end
end

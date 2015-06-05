require 'spec_helper'

describe "Redis Client" do
  let(:redis) { Redis.new }
  before(:each) { redis.flushdb }
  let(:dummy_class) { Class.new { include RedisClient } }
  let(:import_one_record) { dummy_class.new.import_record(record_hash) }
  let(:record_hash) {{
                       last_name: "Triggs",
                       first_name: "Tyler",
                       gender: "male",
                       favorite_color: "red",
                       dob: "19861216",
                       display_dob: "12/16/1986"
                     }}

  context "#import_record" do
    it "imports a single record to redis db" do
      import_one_record
      record_json = redis.smembers("records").last
      record = JSON.parse(record_json)
      expect(record["last_name"]).to eq("Triggs")
    end
  end

  context "#records_from_db" do
    it "gets all records from db, assembles array of ruby hashes" do
      import_one_record
      record = dummy_class.new.records_from_db
      expect(record.class).to be(Array)
      expect(record.first["last_name"]).to eq("Triggs")
    end
  end
end


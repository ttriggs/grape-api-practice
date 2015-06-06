require 'spec_helper'

describe "Redis Client db import & retrieval" do
  let(:redis) { Redis.new }
  before(:each) { redis.flushdb }
  let(:dummy_class) { Class.new { include RedisClient } }
  let(:import_one_record) { dummy_class.new.import_record(record_hash) }
  let(:record_hash) do
    {
      last_name: "Triggs",
      first_name: "Tyler",
      gender: "male",
      favorite_color: "red",
      dob: "19861216",
      display_dob: "12/16/1986"
    }
  end

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

describe "Redis Client sorting" do
  let(:redis) { Redis.new }
  let (:comma_file) { Document.new('./spec/example_seeds/comma_delimiter.txt') }
  let(:dummy_class) { Class.new { include RedisClient } }

  before(:each) do
    redis.flushdb
    comma_file.import_records_to_db
  end

  context "#sort_by_dob" do
    it "orders all records by dob" do
      sorted_dobs = ["19830310", "19830319", "19840610", "19840619"]
      unsorted = dummy_class.new.records_from_db.map { |h| h["dob"] }
      sorted   = dummy_class.new.sort_by_dob.map { |h| h["dob"] }

      expect(sorted).to_not eq(unsorted)
      expect(sorted).to eq(sorted_dobs)
    end
  end

  context "#sort_by_last_name" do
    it "orders all records by last name" do
      sorted_names = ["Stevens", "Lee", "Apple", "Albert"]
      unsorted = dummy_class.new.records_from_db.map { |h| h["last_name"] }
      sorted   = dummy_class.new.sort_by_last_name.map { |h| h["last_name"] }

      expect(sorted).to_not eq(unsorted)
      expect(sorted).to eq(sorted_names)
    end
  end

  context "#sort_by_gender" do
    it "orders all records by gender, then by last name" do
      sorted_genders = ["female", "female", "male", "male"]
      sorted_names = ["Apple", "Lee", "Albert", "Stevens"]

      unsorted_result = dummy_class.new.records_from_db
      sorted_result   = dummy_class.new.sort_by_gender

      result_names    = sorted_result.map { |h| h["last_name"] }
      result_genders  = sorted_result.map { |h| h["gender"] }

      expect(sorted_result).to_not eq(unsorted_result)
      expect(sorted_names).to eq(result_names)
      expect(sorted_genders).to eq(result_genders)
    end
  end
end

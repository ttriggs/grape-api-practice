require 'spec_helper'

describe "Document class" do
  let (:pipe_file) { Document.new('./spec/example_seeds/pipe_delimiter.txt') }
  let (:redis) { Redis.new }
  before(:each) { redis.flushdb }

  context "#records" do
    it "returns array of hashes for records in @file" do
      response = pipe_file.records
      expected_records = File.foreach(pipe_file.file).count
      expect(response.length).to eq(expected_records)
      expect(response.first.class).to be(Hash)
    end
  end

  context "#import_records_to_db" do
    it "adds all new records to redis db" do
      expected_records = File.foreach(pipe_file.file).count
      pipe_file.import_records_to_db
      total_records = redis.smembers("records").count

      expect(total_records).to eq(expected_records)
    end
  end
end

require 'spec_helper'

describe "Document class" do
  let (:pipe_file) { Document.new('./spec/example_seeds/pipe_delimiter.txt') }

  context "#records" do
    it "returns array of hashes for records in @file" do
      response = pipe_file.records
      number_records_expected = File.foreach(pipe_file.file).count
      expect(response.length).to eq(number_records_expected)
      expect(response.first.class).to be(Hash)
    end
  end
end

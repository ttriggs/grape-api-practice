require 'spec_helper'

describe "Document class" do
  let (:comma_file) { './spec/example_seeds/comma_delimiter.txt' }
  let (:pipe_file) { './spec/example_seeds/pipe_delimiter.txt' }
  let (:space_file) { './spec/example_seeds/space_delimiter.txt' }

  context ".initialize" do
    it "assigns #delimiter to ',' when given comma delimited file" do
      file = Document.new(comma_file)
      expect(file.delimiter).to eq(",")
    end

    it "assigns #delimiter to '|' when given pipe delimited file" do
      file = Document.new(pipe_file)
      expect(file.delimiter).to eq("|")
    end

    it "assigns #delimiter to ' ' when given space delimited file" do
      file = Document.new(space_file)
      expect(file.delimiter).to eq(" ")
    end
  end

  context "#first_line" do
    it "returns first line of file" do
      response = Document.new(pipe_file).first_line
      expect(response).to eq("Zachary | Albert | male | red | 19900521")
    end
  end
end

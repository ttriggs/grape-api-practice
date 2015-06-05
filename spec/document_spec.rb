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

  context ".get_delimiter" do
    it "returns ',' when passed a comma seperated string" do
      response = Document.get_delimiter("lastname, firstname")
      expect(response).to eq(",")
    end

    it "returns '|' when passed a pipe seperated string" do
      response = Document.get_delimiter("lastname | firstname")
      expect(response).to eq("|")
    end

    it "returns ' ' when passed a space seperated string" do
      response = Document.get_delimiter("lastname firstname")
      expect(response).to eq(" ")
    end
  end


end

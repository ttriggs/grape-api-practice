require 'spec_helper'


describe "Import Support" do
  let(:dummy_class) { Class.new { include ImportSupport } }

  context "#delimiter" do
    it "returns ',' when passed a comma seperated string" do
      response = dummy_class.new.delimiter("lastname, firstname")
      expect(response).to eq(",")
    end

    it "returns '|' when passed a pipe seperated string" do
      response = dummy_class.new.delimiter("lastname | firstname")
      expect(response).to eq("|")
    end

    it "returns ' ' when passed a space seperated string" do
      response = dummy_class.new.delimiter("lastname firstname")
      expect(response).to eq(" ")
    end
  end
end

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

  context "#display_dob" do
    it "reformat date from yyyymmdd to m/d/yyyy" do
      response = dummy_class.new.display_dob("20110203")
      expect(response).to eq("2/3/2011")
    end
  end
end

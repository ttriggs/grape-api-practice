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
      date = "20110203"
      response = dummy_class.new.display_dob(date)
      expect(response).to eq("2/3/2011")
    end
  end

  context "#parse_record" do
    it "creates array from record string" do
      record = "Triggs, Tyler, male, red, 19861216"
      response = dummy_class.new.parse_record(record)
      expect(response.length).to eq(5)
      expect(response[0]).to eq("Triggs")
      expect(response[1]).to eq("Tyler")
      expect(response[2]).to eq("male")
      expect(response[3]).to eq("red")
      expect(response[4]).to eq("19861216")
    end
  end
end

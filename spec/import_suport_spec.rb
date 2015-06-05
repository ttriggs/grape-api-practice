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
    it "creates hash from record string" do
      record = "Triggs, Tyler, male, red, 19861216"
      response = dummy_class.new.parse_record(record)
      expect(response.length).to eq(6)
      expect(response[:last_name]).to eq("Triggs")
      expect(response[:first_name]).to eq("Tyler")
      expect(response[:gender]).to eq("male")
      expect(response[:favorite_color]).to eq("red")
      expect(response[:dob]).to eq("19861216")
      expect(response[:display_dob]).to eq("12/16/1986")
    end
  end
end

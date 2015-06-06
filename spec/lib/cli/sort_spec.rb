require 'spec_helper'

describe "CliRunner sort methods" do
  let(:redis) { Redis.new }
  let(:comma_file) { Document.new('./spec/example_seeds/comma_delimiter.txt') }
  let(:runner) { CliRunner.new }
  before(:each) do
    redis.flushdb
    comma_file.import_records_to_db
  end

  context "#sort_by_gender" do
    it "prints all records sorted by gender, then last name" do
      arguments = ["sort_by_gender"]
      stdout, _ = capture_output do
        expect(runner.go(arguments)).to eq(0)
      end
      expect(stdout).to include("Showing all records sorted by gender")
      expect(stdout).to include("DOB\nApple\tJulia\tfemale\tblue")
      expect(stdout).to end_with("Stevens\tSteve\tmale\tred\t3/10/1983\n")
    end
  end

  context "#sort_by_last_name" do
    it "prints all records sorted by last name" do
      arguments = ["sort_by_last_name"]
      stdout, _ = capture_output do
        expect(runner.go(arguments)).to eq(0)
      end
      expect(stdout).to include("Showing all records sorted by last name")
      expect(stdout).to include("DOB\nStevens\tSteve\tmale\tred\t3/10/1983")
      expect(stdout).to end_with("Albert\tSteve\tmale\tred\t3/19/1983\n")
    end
  end

  context "#sort_by_dob" do
    it "prints all records sorted by date of birth" do
      arguments = ["sort_by_dob"]
      stdout, _ = capture_output do
        expect(runner.go(arguments)).to eq(0)
      end
      expect(stdout).to include("Showing all records sorted by date of birth")
      expect(stdout).to include("DOB\nStevens\tSteve\tmale\tred\t3/10/1983")
      expect(stdout).to end_with("Lee\tJulia\tfemale\tblue\t6/19/1984\n")
    end
  end
end

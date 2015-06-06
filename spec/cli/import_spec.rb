require 'spec_helper'

describe "#import" do
  let(:valid_file) { './spec/example_seeds/pipe_delimiter.txt' }
  let(:invalid_file) { 'file_doesnt_exist' }
  let(:runner) { CliRunner.new }

  context "when supplied files that do exist" do
    it "imports one or more text files into the database" do
      arguments = ["import", valid_file]

      stdout, _ = capture_output do
        expect(runner.go(arguments)).to eq(0)
      end
      success = "+imported file: ./spec/example_seeds/pipe_delimiter.txt"
      expect(stdout.strip).to eq(success)
    end
  end

  context "when supplied paths to files that do not exist" do
    it "raises an error" do
      arguments = ["import", invalid_file]
      stdout, stderror = capture_output do
        expect(runner.go(arguments)).to eq(1)
      end
    end
  end
end

#!/usr/bin/env ruby
require_relative "./lib/cli_runner.rb"

cli = CliRunner.new
exit cli.go(ARGV)

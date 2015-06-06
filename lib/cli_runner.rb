#!/usr/bin/env ruby
require_relative 'document'
require_relative 'redis_client'
require 'pry'
require 'gli'

class CliRunner
  include RedisClient
  include GLI::App


  def go(args)

    program_desc """
      Store and retrieve sorted records from a redis database.
      Imported text files should have five fields per record:
      LastName | FirstName | Gender | FavoriteColor | DOB(YYYYMMDD)
      delimited by pipes, commas, or white spaces.
      """

    desc "Import records from text file(s) (arguments). \
          Accepts comma, pipe, or space delimited text files."
    command :import do |c|
      c.action do |_global_options, _options, args|
        import_files_to_db(args)
      end
    end

    desc "Sort records by gender, then by last name."
    command :sort_by_gender do |c|
      c.action do |_global_options, _options, _cmdargs|
        display(sort_by_gender, "gender")
      end
    end

    desc "Sort records by date of birth."
    command :sort_by_dob do |c|
      c.action do |_global_options, _options, _cmdargs|
        display(sort_by_dob, "date of birth")
      end
    end

    desc "Sort records by last name."
    command :sort_by_last_name do |c|
      c.action do |_global_options, _options, _cmdargs|
        display(sort_by_last_name, "last name")
      end
    end

    run(args)
  end

  def import_files_to_db(files)
    files.each do |file|
      raise file_not_found_error(file) if !File.file?(file)
      Document.new(file).import_records_to_db
      puts "+imported file: #{file}"
    end
  end

  def file_not_found_error(file)
    StandardError.new("Import failed, file not found: #{file}")
  end

  def display(records, sort_type)
    puts "Showing all records sorted by #{sort_type}"
    puts "LastName\tFirstName\tGender\tFavoriteColor\tDOB"
    records.each do |record|
      record.delete("dob")
      puts record.values.join("\t")
    end
  end
end


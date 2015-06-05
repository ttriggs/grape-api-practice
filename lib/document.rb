require_relative 'import_support'
require_relative 'redis_client'

class Document
  include ImportSupport
  include RedisClient
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def records
    File.readlines(@file).each_with_object([]) do |line, records|
      records << parse_record(line)
    end
  end

  def import_records_to_db
    records.each do |record|
      import_record(record)
    end
  end
end

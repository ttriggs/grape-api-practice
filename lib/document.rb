require_relative 'import_support'

class Document
  include ImportSupport
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def records
    File.readlines(@file).each_with_object([]) do |line, records|
      records << parse_record(line)
    end
  end
end

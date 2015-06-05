require_relative 'import_support'

class Document
  include ImportSupport
  attr_reader :delimiter

  def initialize(file)
    @file = file
  end

  def delimiter
    @delimiter ||= get_delimiter(first_line)
  end

  def first_line
    File.open(@file, &:readline).strip
  end
end

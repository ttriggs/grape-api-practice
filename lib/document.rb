class Document
  attr_reader :delimiter

  def initialize(file)
    @file = file
    @delimiter = Document.get_delimiter(first_line)
  end

  def first_line
    File.open(@file, &:readline).strip
  end

  def self.get_delimiter(record)
    if record.include?("|")
      "|"
    elsif record.include?(",")
      ","
    else
      " "
    end
  end
end

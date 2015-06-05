module ImportSupport
  def get_delimiter(record)
    if record.include?("|")
      "|"
    elsif record.include?(",")
      ","
    else
      " "
    end
  end
end

module ImportSupport
  def delimiter(record)
    if record.include?("|")
      "|"
    elsif record.include?(",")
      ","
    else
      " "
    end
  end

  def display_dob(dob)
    Date.parse(dob).strftime("%-m/%-d/%Y")
  end
end

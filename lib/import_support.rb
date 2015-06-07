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

  def dob_mutate_records(records)
    records.each do |record|
      record["dob"] = display_dob(record["dob"])
    end
  end

  def parse_record(record)
    array = record.split(delimiter(record)).map(&:strip)
    hash_record_from_array(array)
  end

  def hash_record_from_array(array)
    {
      last_name: array[0],
      first_name: array[1],
      gender: array[2],
      favorite_color: array[3],
      dob: array[4]
    }
  end
end

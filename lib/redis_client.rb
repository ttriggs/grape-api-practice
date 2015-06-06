require 'redis'

module RedisClient
  def connection
    @connection ||= Redis.new
  end

  def import_record(record)
    connection.sadd("records", record.to_json)
  end

  def records_from_db
    connection.smembers("records").each_with_object([]) do |record, array|
      array << JSON.parse(record)
    end
  end

  def sort_by_dob
    records_from_db.sort_by { |hash| hash["dob"] }
  end

  def sort_by_last_name(records = records_from_db)
    records.sort_by { |hash| hash["last_name"] }.reverse
  end

  def sort_by_gender
    females = sort_by_last_name(records_select_by("gender", "female"))
    males   = sort_by_last_name(records_select_by("gender", "male"))
    # reverse for last names in ascending order
    females.reverse + males.reverse
  end

  def records_select_by(key, value)
    records_from_db.select { |hash| hash[key] == value}
  end
end

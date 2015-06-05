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
end

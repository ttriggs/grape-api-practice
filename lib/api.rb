require_relative 'redis_client'
require_relative 'import_support'
require 'grape'

module GrapeApp
  class API < Grape::API
    format :json
    helpers RedisClient
    helpers ImportSupport

    helpers do
      def trim_for_display(records)
        records.each { |r| r.delete("dob") }
      end
    end

    get "/records/gender" do
      trim_for_display(sort_by_gender)
    end

    get "/records/birthdate" do
      trim_for_display(sort_by_dob)
    end

    get "/records/name" do
      trim_for_display(sort_by_last_name)
    end

    post "/records" do
      record = parse_record(params["record"])
      import_record(record)
      trim_for_display(sort_by_dob)
    end
  end
end

require_relative 'redis_client'
require_relative 'import_support'
require 'grape'

module GrapeApp
  class API < Grape::API
    format :json
    helpers RedisClient
    helpers ImportSupport

    helpers do
      def prepare_json(records)
        records.map { |r| r.delete("dob") }
        records
      end
    end

    get "/records/gender" do
      prepare_json(sort_by_gender)
    end

    get "/records/birthdate" do
      prepare_json(sort_by_dob)
    end

    get "/records/name" do
      prepare_json(sort_by_last_name)
    end

    post "/records" do
      record = parse_record(params["record"])
      import_record(record)
      prepare_json(sort_by_dob)
    end
  end
end

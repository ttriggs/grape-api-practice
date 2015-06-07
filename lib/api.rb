require_relative 'redis_client'
require_relative 'import_support'
require 'grape'

module GrapeApp
  class API < Grape::API
    format :json
    helpers RedisClient
    helpers ImportSupport

    helpers do
      def get_records(records)
        dob_mutate_records(records)
      end
    end

    get "/records/gender" do
      get_records(sort_by_gender)
    end

    get "/records/birthdate" do
      get_records(sort_by_dob)
    end

    get "/records/name" do
      get_records(sort_by_last_name)
    end

    post "/records" do
      record = parse_record(params["record"])
      import_record(record)
      get_records(sort_by_dob)
    end
  end
end

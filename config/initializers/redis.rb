# frozen_string_literal: true

$redis = Redis.new(url: ENV['STACKHERO_REDIS_URL_TLS']) if ENV['STACKHERO_REDIS_URL_TLS'] # rubocop:disable Style/GlobalVars

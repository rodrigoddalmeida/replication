ENV["RAILS_ENV"] = "test"
REPLICATION_ORM = (ENV["REPLICATION_ORM"] || :active_record).to_sym

$:.unshift File.dirname(__FILE__)

require "rails_app/config/environment"
require "rails/test_help"
require "orm/#{REPLICATION_ORM}"

require "minitest/reporters"
Minitest::Reporters.use!

# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"
require "json"

# This filter requires a set of intput fields that will
# be joined in csv format and saved into the specified
# csv output field
#
class LogStash::Filters::Jsonvalidate < LogStash::Filters::Base

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
  # filter {
  #   jsonvalidate {
  #     test_fields => ['call', 'response']
  #     failed_test_tag => 'not_json'
  #   }
  # }
  #
  config_name "jsonvalidate"
  
  # Fields to use as source for map values
  config :test_fields, :validate => :array

  # tag to add to tag list if not all specified fields are json
  config :failed_test_tag, :validate => :string, :default => "not_json"

  public
  def register
    # Add instance variables 
  end # def register

  public
  def filter(event)
    @logger.debug? and @logger.debug("Running jsonvalidate filter", :event => event)

    @test_fields.each do |field| 
      if !valid_json?(event[field])
        event["tags"] << @failed_test_tag unless event["tags"].include?(@failed_test_tag)
      end
    end

    filter_matched(event)
    @logger.debug? and @logger.debug("Event now: ", :event => event)

  end # def filter

  private
  def valid_json?(json)
    begin 
      JSON.parse(json)
      return true
    rescue JSON::ParserError => e
      @logger.debug? and @logger.debug("Exeception: ", :exception => e)
      return false
    end
  end
end # class LogStash::Filters::Example

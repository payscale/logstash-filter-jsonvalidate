# encoding: utf-8
require 'spec_helper'
require "logstash/filters/jsonvalidate"

describe LogStash::Filters::Jsonvalidate do
  describe "Valid Json" do
    let(:config) do <<-CONFIG
      filter {
        jsonvalidate {
          test_fields => ['call', 'response']
        }
      }
    CONFIG
    end

    sample("call" => "{\"Marco\":\"polo\"}", "response" => "{\"herber\":\"hoover\"}", "tags" =>[]) do
      expect(subject).to include("tags")
      expect(subject['tags']).to eq([])
    end
  end

  describe "Invalid Json" do
    let(:config) do <<-CONFIG
      filter {
        jsonvalidate {
          test_fields => ['call', 'response']
        }
      }
    CONFIG
    end

    sample("call" => "{\"marco\":\"polo\"}", "response" => "totes not json", "tags" => []) do
      expect(subject).to include("tags")
      expect(subject['tags']).to include("not_json")
    end
  end
end

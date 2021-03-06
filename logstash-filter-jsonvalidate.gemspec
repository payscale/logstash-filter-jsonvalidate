Gem::Specification.new do |s|
  s.name = 'logstash-filter-jsonvalidate'
  s.version         = '0.1.0'
  s.licenses = ['Apache License (2.0)']
  s.summary = "This filter will test if a specified field is json.  If not a tag will be set"
  s.description = "This gem is a logstash plugin required to be installed on top of the Logstash core pipeline using $LS_HOME/bin/plugin install gemname. This gem is not a stand-alone program"
  s.authors = ["Patrick Christopher"]
  s.email = 'coffeepac@gmail.com'
  s.homepage = "http://www.elastic.co/guide/en/logstash/current/index.html"
  s.require_paths = ["lib"]

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']
   # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "filter" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core", ">= 2.0.0", "< 7.0.0"
  s.add_development_dependency 'logstash-devutils'
end

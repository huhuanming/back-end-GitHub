# -*- encoding: utf-8 -*-
# stub: goliath 1.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "goliath"
  s.version = "1.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["dan sinclair", "Ilya Grigorik"]
  s.date = "2014-06-22"
  s.description = "Async framework for writing API servers"
  s.email = ["dj2@everburning.com", "ilya@igvita.com"]
  s.homepage = "http://goliath.io/"
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2")
  s.rubygems_version = "2.2.2"
  s.summary = "Async framework for writing API servers"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<eventmachine>, [">= 1.0.0.beta.4"])
      s.add_runtime_dependency(%q<em-synchrony>, [">= 1.0.0"])
      s.add_runtime_dependency(%q<em-websocket>, ["= 0.3.8"])
      s.add_runtime_dependency(%q<http_parser.rb>, ["= 0.6.0"])
      s.add_runtime_dependency(%q<log4r>, [">= 0"])
      s.add_runtime_dependency(%q<rack>, [">= 1.2.2"])
      s.add_runtime_dependency(%q<rack-contrib>, [">= 0"])
      s.add_runtime_dependency(%q<rack-respond_to>, [">= 0"])
      s.add_runtime_dependency(%q<async-rack>, [">= 0"])
      s.add_runtime_dependency(%q<multi_json>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0.8.7"])
      s.add_development_dependency(%q<rspec>, ["> 2.0"])
      s.add_development_dependency(%q<nokogiri>, [">= 0"])
      s.add_development_dependency(%q<em-http-request>, [">= 1.0.0"])
      s.add_development_dependency(%q<em-mongo>, ["~> 0.4.0"])
      s.add_development_dependency(%q<rack-rewrite>, [">= 0"])
      s.add_development_dependency(%q<multipart_body>, [">= 0"])
      s.add_development_dependency(%q<amqp>, [">= 0.7.1"])
      s.add_development_dependency(%q<em-websocket-client>, [">= 0"])
      s.add_development_dependency(%q<tilt>, [">= 1.2.2"])
      s.add_development_dependency(%q<haml>, [">= 3.0.25"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<guard>, ["~> 1.8.3"])
      s.add_development_dependency(%q<guard-rspec>, ["~> 3.1.0"])
      s.add_development_dependency(%q<listen>, ["~> 1.3.1"])
      s.add_development_dependency(%q<yajl-ruby>, [">= 0"])
      s.add_development_dependency(%q<bluecloth>, [">= 0"])
      s.add_development_dependency(%q<bson_ext>, [">= 0"])
      s.add_development_dependency(%q<growl>, ["~> 1.0.3"])
      s.add_development_dependency(%q<rb-fsevent>, [">= 0"])
    else
      s.add_dependency(%q<eventmachine>, [">= 1.0.0.beta.4"])
      s.add_dependency(%q<em-synchrony>, [">= 1.0.0"])
      s.add_dependency(%q<em-websocket>, ["= 0.3.8"])
      s.add_dependency(%q<http_parser.rb>, ["= 0.6.0"])
      s.add_dependency(%q<log4r>, [">= 0"])
      s.add_dependency(%q<rack>, [">= 1.2.2"])
      s.add_dependency(%q<rack-contrib>, [">= 0"])
      s.add_dependency(%q<rack-respond_to>, [">= 0"])
      s.add_dependency(%q<async-rack>, [">= 0"])
      s.add_dependency(%q<multi_json>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0.8.7"])
      s.add_dependency(%q<rspec>, ["> 2.0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<em-http-request>, [">= 1.0.0"])
      s.add_dependency(%q<em-mongo>, ["~> 0.4.0"])
      s.add_dependency(%q<rack-rewrite>, [">= 0"])
      s.add_dependency(%q<multipart_body>, [">= 0"])
      s.add_dependency(%q<amqp>, [">= 0.7.1"])
      s.add_dependency(%q<em-websocket-client>, [">= 0"])
      s.add_dependency(%q<tilt>, [">= 1.2.2"])
      s.add_dependency(%q<haml>, [">= 3.0.25"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<guard>, ["~> 1.8.3"])
      s.add_dependency(%q<guard-rspec>, ["~> 3.1.0"])
      s.add_dependency(%q<listen>, ["~> 1.3.1"])
      s.add_dependency(%q<yajl-ruby>, [">= 0"])
      s.add_dependency(%q<bluecloth>, [">= 0"])
      s.add_dependency(%q<bson_ext>, [">= 0"])
      s.add_dependency(%q<growl>, ["~> 1.0.3"])
      s.add_dependency(%q<rb-fsevent>, [">= 0"])
    end
  else
    s.add_dependency(%q<eventmachine>, [">= 1.0.0.beta.4"])
    s.add_dependency(%q<em-synchrony>, [">= 1.0.0"])
    s.add_dependency(%q<em-websocket>, ["= 0.3.8"])
    s.add_dependency(%q<http_parser.rb>, ["= 0.6.0"])
    s.add_dependency(%q<log4r>, [">= 0"])
    s.add_dependency(%q<rack>, [">= 1.2.2"])
    s.add_dependency(%q<rack-contrib>, [">= 0"])
    s.add_dependency(%q<rack-respond_to>, [">= 0"])
    s.add_dependency(%q<async-rack>, [">= 0"])
    s.add_dependency(%q<multi_json>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0.8.7"])
    s.add_dependency(%q<rspec>, ["> 2.0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<em-http-request>, [">= 1.0.0"])
    s.add_dependency(%q<em-mongo>, ["~> 0.4.0"])
    s.add_dependency(%q<rack-rewrite>, [">= 0"])
    s.add_dependency(%q<multipart_body>, [">= 0"])
    s.add_dependency(%q<amqp>, [">= 0.7.1"])
    s.add_dependency(%q<em-websocket-client>, [">= 0"])
    s.add_dependency(%q<tilt>, [">= 1.2.2"])
    s.add_dependency(%q<haml>, [">= 3.0.25"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<guard>, ["~> 1.8.3"])
    s.add_dependency(%q<guard-rspec>, ["~> 3.1.0"])
    s.add_dependency(%q<listen>, ["~> 1.3.1"])
    s.add_dependency(%q<yajl-ruby>, [">= 0"])
    s.add_dependency(%q<bluecloth>, [">= 0"])
    s.add_dependency(%q<bson_ext>, [">= 0"])
    s.add_dependency(%q<growl>, ["~> 1.0.3"])
    s.add_dependency(%q<rb-fsevent>, [">= 0"])
  end
end

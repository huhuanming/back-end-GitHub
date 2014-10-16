# -*- encoding: utf-8 -*-
# stub: harmonious_dictionary 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "harmonious_dictionary"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Stephen Kong"]
  s.date = "2012-12-03"
  s.description = "\u{548c}\u{8c10}\u{5b9d}\u{5178}\u{7528}\u{4e8e}\u{68c0}\u{67e5}\u{8f93}\u{5165}\u{662f}\u{5426}\u{5305}\u{542b}\u{4e2d}\u{6587}\u{6216}\u{82f1}\u{6587}\u{654f}\u{611f}\u{8bcd}\u{ff0c}\u{5e76}\u{53ef}\u{66ff}\u{6362}\u{4e3a}\u{7279}\u{6b8a}\u{5b57}\u{7b26}\u{3002}\u{901f}\u{5ea6}\u{6bd4}\u{5e38}\u{89c4}\u{7684}\u{6b63}\u{5219}\u{5339}\u{914d}\u{8981}\u{5feb}10\u{500d}\u{4ee5}\u{4e0a}\u{3002}\u{751f}\u{6d3b}\u{5728}\u{5929}\u{671d}\u{ff0c}\u{548c}\u{8c10}\u{5b9d}\u{5178}\u{5fc5}\u{987b}\u{4eba}\u{624b}\u{5fc5}\u{5907}\u{3002}"
  s.email = ["wear63659220@gmail.com"]
  s.executables = ["harmonious_rseg", "harmonious_server"]
  s.files = ["bin/harmonious_rseg", "bin/harmonious_server"]
  s.homepage = "https://github.com/wear/harmonious_dictionary"
  s.rubygems_version = "2.2.2"
  s.summary = "filter any words that need to be harmonized"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end

# -*- encoding: utf-8 -*-
# stub: async-rack 0.5.1 ruby lib

Gem::Specification.new do |s|
  s.name = "async-rack"
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Konstantin Haase"]
  s.date = "2011-02-07"
  s.description = "Makes middleware that ships with Rack bullet-proof for async responses."
  s.email = "konstantin.mailinglists@googlemail.com"
  s.homepage = "http://github.com/rkh/async-rack"
  s.rubygems_version = "2.2.2"
  s.summary = "Makes middleware that ships with Rack bullet-proof for async responses."

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, ["~> 1.1"])
      s.add_development_dependency(%q<rspec>, [">= 1.3.0"])
    else
      s.add_dependency(%q<rack>, ["~> 1.1"])
      s.add_dependency(%q<rspec>, [">= 1.3.0"])
    end
  else
    s.add_dependency(%q<rack>, ["~> 1.1"])
    s.add_dependency(%q<rspec>, [">= 1.3.0"])
  end
end

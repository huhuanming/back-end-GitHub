# -*- encoding: utf-8 -*-
# stub: rack-respond_to 0.9.8 ruby lib

Gem::Specification.new do |s|
  s.name = "rack-respond_to"
  s.version = "0.9.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Martin Aumont"]
  s.date = "2010-01-29"
  s.description = "Rack middleware port of Rails's respond_to feature."
  s.email = "mynyml@gmail.com"
  s.homepage = "http://github.com/mynyml/rack-respond_to"
  s.rubyforge_project = "rack-respond_to"
  s.rubygems_version = "2.2.2"
  s.summary = "Rack middleware port of Rails's respond_to feature"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack-accept-media-types>, [">= 0.6"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
    else
      s.add_dependency(%q<rack-accept-media-types>, [">= 0.6"])
      s.add_dependency(%q<minitest>, [">= 0"])
    end
  else
    s.add_dependency(%q<rack-accept-media-types>, [">= 0.6"])
    s.add_dependency(%q<minitest>, [">= 0"])
  end
end

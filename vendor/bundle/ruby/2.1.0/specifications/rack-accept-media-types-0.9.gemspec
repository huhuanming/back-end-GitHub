# -*- encoding: utf-8 -*-
# stub: rack-accept-media-types 0.9 ruby lib

Gem::Specification.new do |s|
  s.name = "rack-accept-media-types"
  s.version = "0.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["mynyml"]
  s.date = "2009-11-21"
  s.description = "Rack middleware for simplified handling of Accept header. Accept header parser."
  s.email = "mynyml@gmail.com"
  s.homepage = "http://github.com/mynyml/rack-accept-media-types"
  s.rubyforge_project = "rack-accept-media-types"
  s.rubygems_version = "2.2.2"
  s.summary = "Rack middleware for simplified handling of Accept header"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<rack>, [">= 0"])
    else
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<rack>, [">= 0"])
    end
  else
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<rack>, [">= 0"])
  end
end

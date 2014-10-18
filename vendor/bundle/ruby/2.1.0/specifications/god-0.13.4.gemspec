# -*- encoding: utf-8 -*-
# stub: god 0.13.4 ruby lib ext
# stub: ext/god/extconf.rb

Gem::Specification.new do |s|
  s.name = "god"
  s.version = "0.13.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib", "ext"]
  s.authors = ["Tom Preston-Werner", "Kevin Clark", "Eric Lindvall"]
  s.date = "2014-03-05"
  s.description = "An easy to configure, easy to extend monitoring framework written in Ruby."
  s.email = "god-rb@googlegroups.com"
  s.executables = ["god"]
  s.extensions = ["ext/god/extconf.rb"]
  s.extra_rdoc_files = ["README.md"]
  s.files = ["README.md", "bin/god", "ext/god/extconf.rb"]
  s.homepage = "http://god.rubyforge.org/"
  s.rdoc_options = ["--charset=UTF-8"]
  s.rubyforge_project = "god"
  s.rubygems_version = "2.2.2"
  s.summary = "Process monitoring framework."

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<json>, ["~> 1.6"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_development_dependency(%q<twitter>, ["~> 4.0"])
      s.add_development_dependency(%q<prowly>, ["~> 0.3"])
      s.add_development_dependency(%q<xmpp4r>, ["~> 0.5"])
      s.add_development_dependency(%q<dike>, ["~> 0.0.3"])
      s.add_development_dependency(%q<rcov>, ["~> 0.9"])
      s.add_development_dependency(%q<daemons>, ["~> 1.1"])
      s.add_development_dependency(%q<mocha>, ["~> 0.10"])
      s.add_development_dependency(%q<gollum>, ["~> 1.3.1"])
      s.add_development_dependency(%q<airbrake>, ["~> 3.1.7"])
      s.add_development_dependency(%q<nokogiri>, ["~> 1.5.0"])
      s.add_development_dependency(%q<activesupport>, ["< 4.0.0", ">= 2.3.10"])
    else
      s.add_dependency(%q<json>, ["~> 1.6"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_dependency(%q<twitter>, ["~> 4.0"])
      s.add_dependency(%q<prowly>, ["~> 0.3"])
      s.add_dependency(%q<xmpp4r>, ["~> 0.5"])
      s.add_dependency(%q<dike>, ["~> 0.0.3"])
      s.add_dependency(%q<rcov>, ["~> 0.9"])
      s.add_dependency(%q<daemons>, ["~> 1.1"])
      s.add_dependency(%q<mocha>, ["~> 0.10"])
      s.add_dependency(%q<gollum>, ["~> 1.3.1"])
      s.add_dependency(%q<airbrake>, ["~> 3.1.7"])
      s.add_dependency(%q<nokogiri>, ["~> 1.5.0"])
      s.add_dependency(%q<activesupport>, ["< 4.0.0", ">= 2.3.10"])
    end
  else
    s.add_dependency(%q<json>, ["~> 1.6"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rdoc>, ["~> 3.10"])
    s.add_dependency(%q<twitter>, ["~> 4.0"])
    s.add_dependency(%q<prowly>, ["~> 0.3"])
    s.add_dependency(%q<xmpp4r>, ["~> 0.5"])
    s.add_dependency(%q<dike>, ["~> 0.0.3"])
    s.add_dependency(%q<rcov>, ["~> 0.9"])
    s.add_dependency(%q<daemons>, ["~> 1.1"])
    s.add_dependency(%q<mocha>, ["~> 0.10"])
    s.add_dependency(%q<gollum>, ["~> 1.3.1"])
    s.add_dependency(%q<airbrake>, ["~> 3.1.7"])
    s.add_dependency(%q<nokogiri>, ["~> 1.5.0"])
    s.add_dependency(%q<activesupport>, ["< 4.0.0", ">= 2.3.10"])
  end
end

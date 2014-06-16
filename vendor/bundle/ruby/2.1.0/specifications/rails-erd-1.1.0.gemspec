# -*- encoding: utf-8 -*-
# stub: rails-erd 1.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "rails-erd"
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Rolf Timmermans"]
  s.date = "2013-01-17"
  s.description = "Automatically generate an entity-relationship diagram (ERD) for your Rails models."
  s.email = ["r.timmermans@voormedia.com"]
  s.executables = ["erd"]
  s.files = ["bin/erd"]
  s.homepage = "http://rails-erd.rubyforge.org/"
  s.rubyforge_project = "rails-erd"
  s.rubygems_version = "2.2.2"
  s.summary = "Entity-relationship diagram for your Rails models."

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 3.0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 3.0"])
      s.add_runtime_dependency(%q<ruby-graphviz>, ["~> 1.0.4"])
      s.add_runtime_dependency(%q<choice>, ["~> 0.1.6"])
    else
      s.add_dependency(%q<activerecord>, [">= 3.0"])
      s.add_dependency(%q<activesupport>, [">= 3.0"])
      s.add_dependency(%q<ruby-graphviz>, ["~> 1.0.4"])
      s.add_dependency(%q<choice>, ["~> 0.1.6"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 3.0"])
    s.add_dependency(%q<activesupport>, [">= 3.0"])
    s.add_dependency(%q<ruby-graphviz>, ["~> 1.0.4"])
    s.add_dependency(%q<choice>, ["~> 0.1.6"])
  end
end

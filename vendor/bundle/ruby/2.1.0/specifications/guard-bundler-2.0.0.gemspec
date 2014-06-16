# -*- encoding: utf-8 -*-
# stub: guard-bundler 2.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "guard-bundler"
  s.version = "2.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Yann Lugrin"]
  s.date = "2013-10-30"
  s.description = "Guard::Bundler automatically install/update your gem bundle when needed"
  s.email = ["yann.lugrin@sans-savoir.net"]
  s.homepage = "https://rubygems.org/gems/guard-bundler"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2")
  s.rubygems_version = "2.2.2"
  s.summary = "Guard gem for Bundler"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<guard>, ["~> 2.2"])
      s.add_runtime_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<guard>, ["~> 2.2"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<guard>, ["~> 2.2"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end

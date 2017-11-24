# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "tabulous"
  s.version = "2.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.7") if s.respond_to? :required_rubygems_version=
  s.authors = ["Wyatt Greene"]
  s.date = "2014-12-22"
  s.description = "Tabulous provides an easy way to add tabs to your Rails application."
  s.email = ["techiferous@gmail.com"]
  s.homepage = "https://github.com/techiferous/tabulous"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "tabulous"
  s.rubygems_version = "2.0.14"
  s.summary = "Easy tabbed navigation for Rails."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<colored>, ["~> 1.2.0"])
      s.add_runtime_dependency(%q<rails>, ["< 5.0.0", ">= 3.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<capybara>, ["~> 2.0.2"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.13"])
      s.add_development_dependency(%q<launchy>, [">= 0"])
      s.add_development_dependency(%q<diffy>, [">= 0"])
      s.add_development_dependency(%q<sqlite3>, [">= 1.3.9"])
    else
      s.add_dependency(%q<colored>, ["~> 1.2.0"])
      s.add_dependency(%q<rails>, ["< 5.0.0", ">= 3.0"])
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<capybara>, ["~> 2.0.2"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.13"])
      s.add_dependency(%q<launchy>, [">= 0"])
      s.add_dependency(%q<diffy>, [">= 0"])
      s.add_dependency(%q<sqlite3>, [">= 1.3.9"])
    end
  else
    s.add_dependency(%q<colored>, ["~> 1.2.0"])
    s.add_dependency(%q<rails>, ["< 5.0.0", ">= 3.0"])
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<capybara>, ["~> 2.0.2"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.13"])
    s.add_dependency(%q<launchy>, [">= 0"])
    s.add_dependency(%q<diffy>, [">= 0"])
    s.add_dependency(%q<sqlite3>, [">= 1.3.9"])
  end
end

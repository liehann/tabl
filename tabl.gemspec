# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tabl}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Liehann Loots}]
  s.date = %q{2011-09-17}
  s.description = %q{Gem for creating tables in Rails or any other system.}
  s.email = %q{liehannl@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "Guardfile",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/tabl.rb",
    "lib/tabl/column.rb",
    "lib/tabl/definition.rb",
    "lib/tabl/deref_column.rb",
    "lib/tabl/dsl.rb",
    "lib/tabl/formats.rb",
    "lib/tabl/formats/html.rb",
    "lib/tabl/table.rb",
    "spec/integration_spec.rb",
    "spec/lib/post_tables.rb",
    "spec/lib/user_columns.rb",
    "spec/spec_helper.rb",
    "spec/tabl/column_spec.rb",
    "spec/tabl/deref_column_spec.rb",
    "spec/tabl/dsl_spec.rb",
    "spec/tabl/formats/html_spec.rb",
    "spec/tabl/table_spec.rb",
    "tabl.gemspec"
  ]
  s.homepage = %q{http://github.com/liehann/tabl}
  s.licenses = [%q{MIT}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{Gem for creating tables in Rails or any other system.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_runtime_dependency(%q<fastercsv>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.6.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<libnotify>, [">= 0"])
      s.add_development_dependency(%q<guard-rspec>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<fastercsv>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.6.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<libnotify>, [">= 0"])
      s.add_dependency(%q<guard-rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<fastercsv>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.6.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<libnotify>, [">= 0"])
    s.add_dependency(%q<guard-rspec>, [">= 0"])
  end
end


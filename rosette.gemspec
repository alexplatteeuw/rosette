# frozen_string_literal: true

require_relative "lib/rosette/version"

Gem::Specification.new do |spec|
  spec.name        = "rosette"
  spec.version     = Rosette::VERSION
  spec.authors     = ["Alexandre Platteeuw"]
  spec.email       = ["alexplatteeuw@gmail.com"]
  spec.summary     = "Translations manager"
  spec.description = "Add missing translations from the interface of your application"
  spec.license     = "MIT"
  spec.homepage    = "https://github.com/alexplatteeuw/rosette"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,bin,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.require_paths = ["lib"]
  spec.executables << "rosette"

  spec.required_ruby_version = ">= 3.3.0"

  spec.add_dependency "i18n-tasks", "~> 1.1"
  spec.add_dependency "rails", "~> 8.0"
  spec.add_dependency "tty-prompt", "~> 0.23.1"

  spec.add_development_dependency "rspec-rails", "~> 8.0"
end

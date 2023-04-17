require_relative "lib/rosette/version"

Gem::Specification.new do |spec|
  spec.name        = "rosette"
  spec.version     = Rosette::VERSION
  spec.authors     = ["Alexandre Platteeuw"]
  spec.email       = ["alexplatteeuw@gmail.com"]
  spec.summary     = "Translations manager"
  spec.description = "Add missing translations from the interface of your application"
  spec.license     = "MIT"
  
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", "~> 7.0.0"
  
  spec.add_development_dependency "rspec-rails", "~> 6.0.0"
end

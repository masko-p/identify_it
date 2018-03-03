$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "identify_it/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "identify_it"
  s.version     = IdentifyIt::VERSION
  s.authors     = ["Pavlo Masko"]
  s.email       = ["masko.pavlo@gmail.com"]
  s.summary     = "Add Identifier handling to the AR models."
  s.description = "Add Identifier handling to the AR models."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile",
                "README.md"]

  s.add_dependency "rails", "~> 5.1.5"

  s.add_development_dependency "sqlite3"
end

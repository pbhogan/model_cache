$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "model_cache/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "model_cache"
  s.version     = ModelCache::VERSION
  s.authors     = ["Patrick Hogan"]
  s.email       = ["pbhogan@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ModelCache."
  s.description = "TODO: Description of ModelCache."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.add_dependency "rails", "~> 4.2.5.1"
end

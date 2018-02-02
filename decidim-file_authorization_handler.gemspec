# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "decidim/file_authorization_handler/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "decidim-file_authorization_handler"
  s.version = Decidim::FileAuthorizationHandler::VERSION
  s.authors = ["Daniel Gómez", "Xavier Redó"]
  s.email = ["hola@marsbased.com"]
  s.summary = "Census support for Decidim Diputació de Barcelona"
  s.description = "Census uploads via csv files and API integration"
  s.homepage = "https://github.com/marsbased/"
  s.license = "AGPLv3"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "decidim", Decidim::FileAuthorizationHandler::VERSION
  s.add_dependency "decidim-admin", Decidim::FileAuthorizationHandler::VERSION
  s.add_dependency "rails", "~> 5.1.4"

  s.add_development_dependency "decidim-dev", Decidim::FileAuthorizationHandler::VERSION
  s.add_development_dependency "faker"
  s.add_development_dependency "letter_opener_web", "~> 1.3.3"
end

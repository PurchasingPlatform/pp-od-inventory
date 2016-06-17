require File.expand_path("../lib/office_depot/inventory_check/version", __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "od-inventory-check"
  spec.version       = OfficeDepot::InventoryCheck::VERSION
  spec.authors       = ["Dan Sosedoff"]
  spec.email         = ["dan.sosedoff@gmail.com"]
  spec.description   = %q{Office Depot Inventory Check Module}
  spec.summary       = %q{Office Depot Inventory Check Module}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.add_dependency "xml-simple", "~> 1.1"
  spec.add_dependency "faraday",    "~> 0.9"

  spec.add_development_dependency "rspec",     "~> 3.4"
  spec.add_development_dependency "rake",      "~> 10"
  spec.add_development_dependency "simplecov", "~> 0.11"
  spec.add_development_dependency "webmock",   "~> 1.15"

  spec.files = Dir["lib/*.rb"] + Dir["lib/office_depot/*.rb"]
  spec.files += Dir["[A-Z]*"] + Dir["spec/**/*"]

  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.3.1"
end
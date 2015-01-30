# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "office_depot/inventory_check/version"

Gem::Specification.new do |spec|
  spec.name          = "od-inventory-check"
  spec.version       = OfficeDepot::InventoryCheck::VERSION
  spec.authors       = ["Dan Sosedoff"]
  spec.email         = ["dan.sosedoff@gmail.com"]
  spec.description   = %q{Office Depot Inventory Check Module}
  spec.summary       = %q{Office Depot Inventory Check Module}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "xml-simple", "~> 1.1"
  spec.add_dependency "faraday",    "~> 0.9"

  spec.add_development_dependency "bundler",   "~> 1.3"
  spec.add_development_dependency "rspec",     "~> 2.14"
  spec.add_development_dependency "rake",      "~> 10"
  spec.add_development_dependency "simplecov", "~> 0.7"
  spec.add_development_dependency "webmock",   "~> 1.15"
end
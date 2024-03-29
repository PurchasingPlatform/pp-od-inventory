require "simplecov"

SimpleCov.start do
  add_filter "/spec/"
  add_filter "/.bundle/"
end

require "webmock/rspec"
require "office_depot/inventory_check"

def fixture_path(filename=nil)
  path = File.expand_path("../fixtures", __FILE__)
  filename.nil? ? path : File.join(path, filename)
end

def fixture(file)
  File.read(File.join(fixture_path, file))
end
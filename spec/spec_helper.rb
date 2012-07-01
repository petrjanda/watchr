$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'shoulda/matchers/active_model'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

# Include ActiveModel matchers from Shoulda into RSpec Matchers
module RSpec::Matchers
  include Shoulda::Matchers::ActiveModel
end

RSpec.configure do |config|
  config.mock_with :mocha
end

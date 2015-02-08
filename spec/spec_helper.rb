$LOAD_PATH.unshift('./lib') unless $LOAD_PATH.include?('./lib')

require 'bowling'

RSpec.configure do |config|
  config.expect_with :rspec
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.warnings = true
  config.profile_examples = 10
  config.order = :random

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  Kernel.srand config.seed
end

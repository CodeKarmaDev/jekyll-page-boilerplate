require "bundler/setup"
require "jekyll_page_boilerplate"

require 'fileutils'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!
  
  config.after(:all) do 
    FileUtils.rm Dir.glob('test/*')
  end
  
  config.after(:suite) do 
    FileUtils.rm Dir.glob('_boilerplates/example.yml')
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

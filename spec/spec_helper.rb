require "bundler/setup"
require "jekyll_page_boilerplate"

require 'fileutils'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!
 
  config.before(:suite) do
    FileUtils.mkdir 'test'
  end

  config.after(:each) do 
    FileUtils.rm_r Dir.glob('test/*')
  end
  
  config.after(:suite) do 
    FileUtils.rm Dir.glob('_boilerplates/example.yml')
    FileUtils.rm_r 'test'
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

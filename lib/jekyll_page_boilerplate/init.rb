require 'fileutils'

module JekyllPageBoilerplate
  class Init

    def self.run
      self.setup
      return 'Created _boilerplates/example.md'
    end
    
    def self.setup
      FileUtils.mkpath('_boilerplates')
      FileUtils.cp(File.join(__dir__, 'example.md'), '_boilerplates')
    end
  end
end

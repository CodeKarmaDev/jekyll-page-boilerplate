require 'fileutils'

module JekyllPageBoilerplate
  module Init
    def self.setup
      FileUtils.mkpath('_boilerplates')
      FileUtils.cp(File.join(__dir__, 'example.md'), '_boilerplates')
    end
  
  end
end
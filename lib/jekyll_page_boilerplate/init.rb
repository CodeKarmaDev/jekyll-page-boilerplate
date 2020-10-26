require 'fileutils'

module JekyllPageBoilerplate
  module Init
    def self.setup
      FileUtils.mkpath('_boilerplates')
      FileUtils.cp(File.join(__dir__, 'example.yml'), '_boilerplates')
    end
  
  end
end
require 'fileutils'

module JekyllPageBoilerplate
  module Init
    def self.setup
      FileUtils.mkpath('_boilerplates')
      FileUtils.cp('lib/jekyll_page_boilerplate/example.yml', '_boilerplates')
    end
  
  end
end
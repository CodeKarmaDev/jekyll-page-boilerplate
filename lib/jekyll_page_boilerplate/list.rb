
module JekyllPageBoilerplate

  class List

    SPACER = '\n'
    REMOVE_SUFFIX = /\.\w+(?=[\s\n\r$])/

    def self.run
      Dir.glob("_boilerplates/*").map do |f|
        File.basename(f, '.*')
      end
    end

  end
end

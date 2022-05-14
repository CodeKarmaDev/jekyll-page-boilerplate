
module JekyllPageBoilerplate

  class List
    
    def self.run
      Dir.glob("_boilerplates/*").map do |f|
        File.basename(f, '.*')
      end
    end

  end
end

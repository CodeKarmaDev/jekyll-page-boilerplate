
require 'yaml'

module JekyllPageBoilerplate
  class Page

    BOILERPLATES_PATH = '_boilerplates'
    FILE_DATE_FORMATE = '%Y-%m-%d'

    def self.build boilerplate, title
      self.new(boilerplate).create title
    end

    def initialize boilerplate, suffix: '.yml' 
      plate_path = File.join(BOILERPLATES_PATH, "#{boilerplate}#{suffix}")
      
      set_boilerplate_from_yaml_file( plate_path )
    end
    
    def create title
      abort_unless_file_exists(@boilerplate['path'])
      
      add_header_title( title )
      add_header_created()
      
      create_new_page( title )

      @boilerplate
    end

    private

    def create_new_page title
      filename = get_new_page_filename( title )
      
      new_file_path = File.join( @boilerplate['path'], filename )

      abort_if_file_exists(new_file_path)

      open(new_file_path, 'w') do |page|
        page.puts @boilerplate['header'].to_yaml
        page.puts '---'
      end
      
    end


    def add_header_created
      @boilerplate['header']['created'] = Time.now.to_s
    end
    
    def add_header_title title
      @boilerplate['header']['title'] = title.gsub(/[&-]/, '&'=>'&amp;', '-'=>' ')
    end


    def set_boilerplate_from_yaml_file yaml_path
      abort_unless_file_exists( yaml_path )
      
      @boilerplate = {} 
      
      File.open(yaml_path, 'r') do |yaml_file|
        @boilerplate = YAML.load( yaml_file.read )
      end
    end
    

    def get_new_page_filename title
      title = title.to_url
      title = "#{title}#{@boilerplate['suffix'] || '.markdown'}"
      if @boilerplate['timestamp']
        title = "#{Time.now.strftime(FILE_DATE_FORMATE)}-#{title}"
      end
      return title
    end



    def abort_if_file_exists(file_path)
      if File.exist?(file_path)
        abort("#{file_path} already exists!")
      end
    end

    def abort_unless_file_exists(file_path)
      unless File.exist?(file_path)
        abort("#{file_path} does not exist!")
      end
    end


  end

end
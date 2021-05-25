
require 'yaml'
require "stringex"

module JekyllPageBoilerplate
  class Page

    BOILERPLATES_PATH = '_boilerplates'
    FILE_DATE_FORMATE = '%Y-%m-%d'
    READ_CONFIG_REGEX = /^_boilerplate:(\s*^[\t ]{1,2}.+$)+/
    READ_FILE_REGEX = /^-{3}\s*$(?<head>[\s\S]*)^-{3}\s$(?<body>[\s\S]*)/


    def initialize boilerplate

      plate_path = get_boilerplate_path(boilerplate)
      
      abort_unless_file_exists( plate_path )

      parsed_file = {}
      File.open(plate_path, 'r') do |file|
        parsed_file = file.read.match(READ_FILE_REGEX).named_captures
      end

      @config = get_config(parsed_file['head'])       
      @head = get_head(parsed_file['head'])
      @body = get_body(parsed_file['body'])
    end
    
    def create title
      abort_unless_file_exists(@config['path'])
      
      set_header_entry 'title', title.gsub(/[&-]/, '&'=>'&amp;', '-'=>' ')
      set_header_entry 'created', Time.now.to_s

      create_new_page get_new_page_filename(title)
    end

    private
    
    def create_new_page filename
      new_file_path = File.join( @config['path'], filename )

      abort_if_file_exists(new_file_path)

      open(new_file_path, 'w') do |page|
        page.puts '---'
        page.puts @head
        page.puts '---'
        page.puts @body
        page.puts ''
      end      
    end


    def set_header_entry key, val
      @head << "\n#{key}: null" unless @head.match /^#{key}:.*$/
      @head.gsub! /^#{key}:.*$/, "#{key}: #{val}"
    end

    def get_body markdown
      return markdown
    end

    def get_config head
      return YAML.load(head.match(READ_CONFIG_REGEX).to_s)['_boilerplate']
    end

    def get_head head
      return head.gsub READ_CONFIG_REGEX, ''
    end
    

    def get_boilerplate_path plate_name
      return Dir.glob( 
        "#{File.join(BOILERPLATES_PATH, plate_name)}.{md,markdown,MD,MARKDOWN}" 
      ).first
    end


    def get_new_page_filename title
      title = title.to_url
      title = "#{title}#{@config['suffix'] || '.markdown'}"
      if @config['timestamp']
        title = "#{Time.now.strftime(FILE_DATE_FORMATE)}-#{title}"
      end
      return title
    end



    def abort_if_file_exists(file_path)
      if File.exist?(file_path)
        raise "#{file_path} already exists!"
      end
    end

    def abort_unless_file_exists(file_path)
      unless File.exist?(file_path)
        raise "#{file_path} does not exist!"
      end
    end


  end

end
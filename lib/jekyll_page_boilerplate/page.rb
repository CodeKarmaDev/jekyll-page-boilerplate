
require 'yaml'
require "stringex"

module JekyllPageBoilerplate
  BOILERPLATES_PATH = '_boilerplates'
  
  class Page

    FILE_DATE_FORMATE = '%Y-%m-%d'
    READ_CONFIG_REGEX = /[\r\n\s]{0,}^_boilerplate:(\s*^[\t ]{1,2}.+$)+[\r\s\n]{0,}(?![^\r\s\n])/
    READ_FILE_REGEX = /^-{3}\s*^(?<head>[\s\S]*)^-{3}\s^(?<body>[\s\S]*)/


    def initialize boilerplate, options
      plate_path = get_boilerplate_path(boilerplate).to_s

      abort_unless_file_exists( plate_path )

      parsed_file = {}
      File.open(plate_path, 'r') do |file|
        parsed_file = file.read.match(READ_FILE_REGEX).named_captures
      end

      @config = get_config(parsed_file['head']).merge(options)
      @config['suffix'] ||= plate_path[/\.\w+$/]
      @config['name'] ||= plate_path[/.*(?=\.)/] || plate_path
      @head = get_head(parsed_file['head'])
      @body = get_body(parsed_file['body'])
    end
    
    def create
      @config['time'] ||= Time.now.to_s
      @config['date'] ||= Time.now.strftime(FILE_DATE_FORMATE)

      abort_unless_file_exists(@config['path'])
      
      @config['file'] ||= get_new_page_filename(@config['title'] || @config['name'])

      config_template

      create_new_page @config['file']
    end

    private
    
    def create_new_page filename
      new_file_path = File.join( @config['path'], filename )

      abort_if_file_exists(new_file_path)

      open(new_file_path, 'w') do |page|
        page.puts '---'
        page.puts @head.lstrip
        page.puts '---'
        page.puts @body
        page.puts ''
      end      
    end

    def config_template
      @config.each do |k,v|
        fill_template k, v
      end
    end

    def fill_template key, val
      @head.gsub! /\{{2}\s{0,}boilerplate\.#{key}\s{0,}\}{2}/, @config[key].to_s
      @body.gsub! /\{{2}\s{0,}boilerplate\.#{key}\s{0,}\}{2}/, @config[key].to_s
    end

    def get_body markdown
      return markdown
    end

    def get_config head
      return YAML.load(head.match(READ_CONFIG_REGEX).to_s)['_boilerplate']
    end

    def get_head head
      return head.gsub( READ_CONFIG_REGEX, '')
    end
    

    def get_boilerplate_path plate_name
      return Dir.glob( 
        "#{File.join(BOILERPLATES_PATH, plate_name)}*" 
      ).first
    end


    def get_new_page_filename title
      title = title.to_url
      title = "#{title}#{@config['suffix']}"
      if @config['timestamp']
        title = "#{@config['date']}-#{title}"
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
        raise "The file `#{file_path}` does not exist!"
      end
    end


  end

end
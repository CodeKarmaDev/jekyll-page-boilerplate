
require 'yaml'
require "stringex"
require 'securerandom'

class JekyllPageBoilerplate::Page
  
  BOILERPLATES_PATH = '_boilerplates'
  FILE_DATE_FORMATE = '%Y-%m-%d'
  READ_CONFIG_REGEX = /[\r\n\s]{0,}^_boilerplate:(\s*^[\t ]{1,2}.+$)+[\r\s\n]{0,}(?![^\r\s\n])/
  READ_FILE_REGEX = /^-{3}\s*^(?<head>[\s\S]*)^-{3}\s^(?<body>[\s\S]*)/
  TAGS_REGEX = /\{{2}\s{0,}boilerplate\.([^\{\}\.\s]+)\s{0,}\}{2}/
  TAG_SLUG = /\{{2}\s{0,}([^\{\}\.\s]+)\s{0,}\}{2}/



  attr_reader :config

  def self.run boilerplate, options
    page = self.new(boilerplate, options)
    page.create
    return "Created %s/%s" % [page.config['path'], page.config['file']]
  end

  def initialize boilerplate, options
    options.compact!
    options.transform_keys!(&:to_s)
    plate_path = get_boilerplate_path(boilerplate).to_s

    abort_unless_file_exists( plate_path )

    parsed_file = {}
    File.open(plate_path, 'r') do |file|
      parsed_file = file.read.match(READ_FILE_REGEX).named_captures
    end

    @config = get_config(parsed_file['head']).merge(options)
    @config['suffix'] ||= plate_path[/\.\w+$/]
    @config['name'] ||= plate_path[/.*(?=\.)/] || plate_path
    unless @config['slug'] 
      if @config['timestamp']
        @config['slug'] = '{{ date }}-{{ title }}{{ suffix }}' 
      else
        @config['slug'] = '{{ title }}{{ suffix }}' 
      end
    end
    @head = get_head(parsed_file['head'])
    @body = get_body(parsed_file['body'])
  end
  
  def create
    @config['time'] ||= Time.now.to_s
    @config['date'] ||= Time.now.strftime(FILE_DATE_FORMATE)

    abort_unless_file_exists(@config['path'])
    
    scan_slug
    @config['file'] ||= @config['slug'] 

    scan_template :@body
    scan_template :@head

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

  def scan_template var
    instance_variable_get(var).scan(TAGS_REGEX).flatten.uniq.each do |tag|
      instance_variable_get(var).gsub! /\{{2}\s{0,}boilerplate\.#{tag}\s{0,}\}{2}/, get_tag_value(tag)
    end
  end

  def scan_slug
    @config['slug'].scan(TAG_SLUG).flatten.uniq do |tag|
      @config['slug'].gsub! /\{{2}\s{0,}#{tag}\s{0,}\}{2}/, get_tag_value(tag)
    end
    @config['slug'].gsub!(/[^0-9A-Za-z\.\-_]/, '-')
    @config['slug'].downcase!
  end

  def get_tag_value(key)
    return @config[key].to_s if @config[key]
    return @config['name'] if key == 'title'
    key = key.split('=')
    return Tag.send(key[0].to_sym, *key[1]&.split(','))
  end
 
  class Tag
    class << self
      def method_missing *args
        ''
      end

      def random_url length = nil
        length && length = length.to_i
        SecureRandom.urlsafe_base64(length)
      end
    end
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


require 'yaml'
require "stringex"
require 'securerandom'
require 'fileutils'

class JekyllPageBoilerplate::Page
  
  BOILERPLATES_PATH = '_boilerplates'
  READ_CONFIG_REGEX = /[\r\n\s]{0,}^_boilerplate:(\s*^[\t ]{1,2}.+$)+[\r\s\n]{0,}(?![^\r\s\n])/
  READ_FILE_REGEX = /^-{3}\s*^(?<head>[\s\S]*)^-{3}\s^(?<body>[\s\S]*)/
  TAGS_REGEX = /\{{2}\s{0,}boilerplate\.([^\{\}\.\s]+)\s{0,}\}{2}/


  attr_reader :tags

  def self.run boilerplate, *options
    page = self.new(boilerplate, *options)
    page.create
    return "Created "+ File.join(page.tags['path'], page.tags['file'])
  end

  def initialize boilerplate, *options, **params
    plate_path = get_boilerplate_path(boilerplate)
    abort_unless_file_exists( plate_path )

    parsed_file = {}
    File.open(plate_path, 'r') do |file|
      parsed_file = file.read.match(READ_FILE_REGEX).named_captures
    end

    @tags = JekyllPageBoilerplate::Tags.new(
      defaults(plate_path),
      get_header_config(parsed_file['head']),
      *options,
      params
    )
    @tags[:file] = '{{ date }}-{{ slug }}{{ suffix }}' if @tags.timestamp
    @tags.fill(:slug, :file, :path, safe: true)

    @head = get_head(parsed_file['head'])
    @body = parsed_file['body']
  end
  
  def create
    FileUtils.mkdir_p(@tags.path)

    scan_template :@body
    scan_template :@head

    create_new_page
  end
  
  private
  
  def defaults(plate_path, timestamp: false)
    basename = File.basename(plate_path, '.*')
    {
      suffix: plate_path[/\.\w+$/],
      name: plate_path[/.*(?=\.)/] || plate_path,
      basename: basename,
      title: basename,
      slug: '{{ title }}',
      path: '_posts/',
      file: '{{ slug }}{{ suffix }}',
    }
  end
  
  def create_new_page
    new_file_path = File.join( @tags.path, @tags.file )

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
      instance_variable_get(var).gsub! /\{{2}\s{0,}boilerplate\.#{tag}\s{0,}\}{2}/, @tags[tag].to_s
    end
  end

  def get_header_config head
    return YAML.load(head.match(READ_CONFIG_REGEX).to_s)['_boilerplate']
  end

  def get_head head
    return head.gsub( READ_CONFIG_REGEX, '')
  end
  
  def get_boilerplate_path plate_name
    return Dir.glob( "#{File.join(BOILERPLATES_PATH, plate_name)}*" ).first.to_s
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

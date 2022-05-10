require "bales"
require 'jekyll_page_boilerplate'

class JekyllPageBoilerplate::Application < Bales::Application
  version JekyllPageBoilerplate::VERSION
  description JekyllPageBoilerplate::DESCRIPTION

  # `boilerplate <page>`  
  option :title, type: String, long_form: '--title', short_form: '-T',
    description: "`path/<title>.md`"
  option :path, type: String, long_form: '--path', short_form: '-p',
    description: "`<path>/title.md`"
  option :timestamp, type: TrueClass, long_form: '--timestamp', short_form: '-s',
    description: "`path/<time.now>-title.md`"
  option :suffix, type: String, long_form: '--suffix', short_form: '-x',
    description: "`path/title.<md, markdown, txt>`"

  action do |plate, title: nil, path: nil, timestamp: nil, suffix: nil|
    JekyllPageBoilerplate.page plate, {title: title, path: path, suffix: suffix, timestamp: timestamp}
  end

  # `boilerplate readme`  
  command 'readme' do
    description "Helpful info"
    action do
      JekyllPageBoilerplate.readme
    end
  end

  # `boilerplate help`  
  command 'help', parent: Bales::Command::Help

  # `boilerplate init`  
  command 'init' do
    description "Creates an example boilerplate."
    action do
      JekyllPageBoilerplate.init
    end
  end
  
  # `boilerplate list`  
  command 'list' do
    description "List all the boilerplates"
    action do 
      JekyllPageBoilerplate.list
    end
  end
  

  def self.run(*args, **opts)
    begin
      super
    rescue => e
      JekyllPageBoilerplate.readme 
    end
  end

  # parse_and_run
end

JekyllPageBoilerplate::Application.parse_and_run

# Mercenary.program(:boilerplate) do |p|
#   p.version JekyllPageBoilerplate::VERSION
#   p.description 'jekyll-page-boilerplate is a gem for jekyll that helps you generate new pages'
#   p.syntax "boilerplate <subcommand> [options]"
  
#   p.command(:create) do |c|
#     c.syntax 'create BOILERPLATE_NAME [options]'
#     c.description "Creates a page or post from a boilerplate."
  
#     c.option 'path', '-p FILE', '--path FILE', 'Sets the path to create the new file at'
#     c.option 'timestamp', '--timestamp', 'Use timestames in the filename'
#     c.option 'suffix', '--suffix STRING', 'Define the ending suffix (md, markdown, txt)'
#     c.option 'title', '-T STRING', '--title STRING', 'Sets the title of the post.'

#     c.action do |args, options|
#       JekyllPageBoilerplate.page args[0], options, c
#     end
  
#     c.alias :make
#     c.alias :post
#     c.alias :page
#     c.alias :blog
#   end

#   p.command(:list) do |c|
#     c.syntax 'list'
#     c.description "List all the boilerplates"

#     c.action do
#     end
#   end

#   p.command(:help) do |c|
#     c.syntax "help"
#     c.description "Describe what jekyll-page-boilerplate does."
  
#     c.action do
#       JekyllPageBoilerplate.help c
#     end
#   end
  
#   p.command(:init) do |c|
#     c.syntax "init"
#     c.description "Creates an example boilerplate."
  
#     c.action do
#       JekyllPageBoilerplate.init c
#     end
#   end 
  
#   p.default_command(:help)
# end 
  
  
  
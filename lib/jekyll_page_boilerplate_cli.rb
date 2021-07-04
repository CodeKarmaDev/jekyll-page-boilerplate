require "mercenary"
require 'jekyll_page_boilerplate'

Mercenary.program(:boilerplate) do |p|
  p.version JekyllPageBoilerplate::VERSION
  p.description 'jekyll-page-boilerplate is a gem for jekyll that helps you generate new pages'
  p.syntax "boilerplate <subcommand> [options]"
  
  p.command(:create) do |c|
    c.syntax 'create BOILERPLATE_NAME [options]'
    c.description "Creates a page or post from a boilerplate."
  
    c.option 'path', '-p FILE', '--path FILE', 'Sets the path to create the new file at'
    c.option 'timestamp', '--timestamp', 'Use timestames in the filename'
    c.option 'suffix', '--suffix STRING', 'Define the ending suffix (md, markdown, txt)'
    c.option 'title', '-T STRING', '--title STRING', 'Sets the title of the post.'

    c.action do |args, options|
      JekyllPageBoilerplate.page args[0], options, c
    end
  
    c.alias :make
    c.alias :post
    c.alias :page
    c.alias :blog
  end
 
  p.command(:list) do |c|
    c.syntax 'list'
    c.description "List all the boilerplates"

    c.action do
      JekyllPageBoilerplate.list c
    end
  end

  p.command(:help) do |c|
    c.syntax "help"
    c.description "Describe what jekyll-page-boilerplate does."
  
    c.action do
      JekyllPageBoilerplate.help c
    end
  end
  
  p.command(:init) do |c|
    c.syntax "init"
    c.description "Creates an example boilerplate."
  
    c.action do
      JekyllPageBoilerplate.init c
    end
  end 
  
  p.default_command(:help)
end 
  
  
  
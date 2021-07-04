require "mercenary"
require 'jekyll_page_boilerplate'

Mercenary.program(:boilerplate) do |p|
    p.version JekyllPageBoilerplate::VERSION
    p.description 'jekyll-page-boilerplate is a gem for jekyll that helps you generate new pages'
    p.syntax "boilerplate <subcommand> [options]"
  
    p.command(:create) do |c|
        c.syntax 'create BOILERPLATE_NAME [options]'
        c.description "Creates a page or post from a boilerplate."
    
        c.option 'path', '-p', '--path', 'Sets the path to create the new file at'
        c.option 'timestamp', '--timestamp', 'Use timestames in the filename'
        c.option 'title', '-t', '--title', 'Sets the title of the post.'
        c.option 'title', '-c', '--config', 'Adds elements to the config options', Array, 'the config options'
    
        c.action do |args, options|
          $stdout.puts options
          JekyllPageBoilerplate.page args[0], options, c
        end
    
        c.alias :page
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
  
  
  
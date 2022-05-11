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

end

JekyllPageBoilerplate::Application.parse_and_run

  
  
  
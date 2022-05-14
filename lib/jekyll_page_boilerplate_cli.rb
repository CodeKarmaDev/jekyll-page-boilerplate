require "bales"
require 'jekyll_page_boilerplate'

class JekyllPageBoilerplate::Application < Bales::Application
  version JekyllPageBoilerplate::VERSION
  description JekyllPageBoilerplate::Msg.description
  summary JekyllPageBoilerplate::Msg::SUMMARY
  # `boilerplate <page>`  
  option :title, type: String, long_form: '--title', short_form: '-T',
    description: "`path/<title>.md`"
  option :path, type: String, long_form: '--path', short_form: '-p',
    description: "`<path>/title.md`"
  option :slug, type: String, long_form: '--slug', short_form: '-u',
    description: "`path/<slug-template>.md` `{{title}}-{{date}}`"
  option :timestamp, type: TrueClass, long_form: '--timestamp', short_form: '-s',
    description: "`path/<time.now>-title.md`"
  option :suffix, type: String, long_form: '--suffix', short_form: '-x',
    description: "`path/title.<md, markdown, txt>`"

  action do |plate, *custom, title: nil, slug: nil, path: nil, timestamp: nil, suffix: nil|
    custom = Hash[custom.map {|v| v.split('=')}]
    JekyllPageBoilerplate.page plate, custom.merge({
      title: title, path: path, slug: slug,
      suffix: suffix, timestamp: timestamp
    })
  end

  # `boilerplate help`  
  command 'help', parent: Bales::Command::Help

  # `boilerplate init`  
  command 'init' do
    summary "Creates an example boilerplate."
    action do
      JekyllPageBoilerplate.init
    end
  end
  
  # `boilerplate list`  
  command 'list' do
    summary "List all the boilerplates"
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

  
  
  
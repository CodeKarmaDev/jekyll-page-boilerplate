require 'thor'
require 'jekyll_page_boilerplate'



class JekyllPageBoilerplate::Application < Thor
  
  SHARED_OPTIONS = {
    title: { type: :string, aliases: [:t], desc: "`path/<title>.md` `'Foo Bar' > foo-bar.md`" },
    path: { type: :string, aliases: [:p], desc: "`<path>/title.md`" },
    slug: { type: :string, aliases: [:u], desc: "`path/<slug-template>.md` `{{title}}-{{date}}`" },
    timestamp: { type: :boolean, aliases: [:s], desc: "`path/<time.now>-title.md`" },
    suffix: { type: :string, aliases: [:x], desc: "`path/title.<md, markdown, txt>`" }
    # TODO: rename suffix to ext ^^^
  }

  desc "version", "Print the current version."
  def version
    puts JekyllPageBoilerplate::VERSION.to_s
  end

  desc "init", "Creates an example boilerplate."
  def init
    puts JekyllPageBoilerplate.init
  end

  desc "list", "List all the boilerplates."
  def list
    JekyllPageBoilerplate.list
  end

  desc "create BOILERPLATE TITLE [CUSTOM] (--options)", "Generates a new file from a boilerplate."
  SHARED_OPTIONS.each do |name, opt_args|
    option name, **opt_args
  end
  def create plate, title = nil, *args
    _options = options.dup.transform_values(&:dup) || {}
    _options[:title] ||= title if title
    JekyllPageBoilerplate.page plate, args, _options
  end

  desc "readme", "Print out the readme"
  def readme
    JekyllPageBoilerplate.readme
  end

  Dir['_boilerplates/*'].each do |file|
    cmd = File.basename(file, '.*').to_sym
    desc "#{cmd} TITLE [CUSTOM] (--options)", "Alias for `bplate create #{cmd} ...`"
    SHARED_OPTIONS.each do |name, opt_args|
      option name, **opt_args
    end
    define_method cmd do |title = nil, *args|
      _options = options.dup.transform_values(&:dup) || {}
      _options[:title] ||= title if title
      JekyllPageBoilerplate.page cmd, args, _options
    end
  end

  default_task :readme
end

JekyllPageBoilerplate::Application.start(ARGV)


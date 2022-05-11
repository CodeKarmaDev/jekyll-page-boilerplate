require_relative 'lib/jekyll_page_boilerplate/version'
require_relative 'lib/jekyll_page_boilerplate/msg'

Gem::Specification.new do |spec|
  spec.name          = "jekyll-page-boilerplate"
  spec.version       = JekyllPageBoilerplate::VERSION
  spec.authors       = ["Sean Ferney"]
  spec.email         = ["sean@codekarma.dev"]

  spec.summary       = JekyllPageBoilerplate::Msg::SUMMARY
  spec.description   = JekyllPageBoilerplate::Msg.description
  spec.homepage      = "https://github.com/CodeKarmaDev/jekyll-page-boilerplate"
  spec.license       = "MIT"


  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").select { |f| f.match(%r{^(lib|exe|LICENSE|README|Rakefile)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency('bales', '~> 0.1.3')
  spec.add_runtime_dependency("stringex", '~> 2.8', '>= 2.8.5')

end

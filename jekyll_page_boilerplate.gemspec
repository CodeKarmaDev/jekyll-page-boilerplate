require_relative 'lib/jekyll_page_boilerplate/version'

Gem::Specification.new do |spec|
  spec.name          = "jekyll-page-boilerplate"
  spec.version       = JekyllPageBoilerplate::VERSION
  spec.authors       = ["opsaaaaa"]
  spec.email         = ["sean@ferney.org"]

  spec.summary       = "A jekyll plugin that allows you to create new pages from a boilerplate"
  spec.description   = "A jekyll plugin that allows you to create new pages from a boilerplate"
  spec.homepage      = "https://github.com/CodeKarmaDev/jekyll-page-boilerplate"
  spec.license       = "MIT"


  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").select { |f| f.match(%r{^(lib|bin|LICENSE|README|Rakefile)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency("mercenary", "0.4.0")
  spec.add_runtime_dependency("stringex")
end

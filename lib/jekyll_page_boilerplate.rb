require "jekyll_page_boilerplate/version"

module JekyllPageBoilerplate
  class Error < StandardError; end

  def test
    puts 'testing gem from file'
  end

  def create template, title

    # JekyllPageBoilerplate::Template.new(template).create title
  end

end

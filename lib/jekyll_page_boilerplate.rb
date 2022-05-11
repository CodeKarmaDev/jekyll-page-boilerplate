require "jekyll_page_boilerplate/version"
require "jekyll_page_boilerplate/msg"
require "jekyll_page_boilerplate/page"
require "jekyll_page_boilerplate/init"
require "jekyll_page_boilerplate/list"


module JekyllPageBoilerplate
  class Error < StandardError; end

  def self.init 
    Msg.try_and_report do
      Init.run
    end
  end

  def self.list
    Msg.try_and_report do
      List.run
    end
  end

  def self.readme
    Msg.file 'description.md'
  end

  def self.page boilerplate_name, options
    Msg.try_and_report do
      Page.run(boilerplate_name, options)
    end
  end  

end

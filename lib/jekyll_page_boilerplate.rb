require "jekyll_page_boilerplate/version"
require "jekyll_page_boilerplate/page"
require "jekyll_page_boilerplate/msg"
require "jekyll_page_boilerplate/init"

module JekyllPageBoilerplate
  class Error < StandardError; end


  def self.init cmd
    begin
      Init.setup
    rescue => e
      cmd.logger.fatal e.message
    end
  end


  def self.help cmd
    cmd.logger.info Msg::HELP
  end


  def self.page boilerplate_name, page_title, cmd
    page = Page.new(boilerplate_name)
    begin
      page.create(page_title)
    rescue => e
      cmd.logger.fatal e.message
    end
  end

end

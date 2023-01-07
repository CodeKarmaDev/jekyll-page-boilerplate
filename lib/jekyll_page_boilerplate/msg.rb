
module JekyllPageBoilerplate::Msg

  SUMMARY = "A jekyll plugin that allows you to create new pages or posts from a boilerplate through the terminal."  

  def self.file name
    puts self.read_file name
  end

  def self.description
    self.read_file('description.md')
  end

  def self.read_file name
    File.read(File.join(__dir__, 'msg', name))
  end
  
  def self.error(**msgs)
    msgs.each {|k,v| puts(k.to_s.capitalize!+': '+v)}
  end

  def self.info msg
    puts msg
  end

  def self.try_and_report &block
    begin
      self.info block.call
    rescue => e
      if e.kind_of?(JekyllPageBoilerplate::Error)
        self.error fatal: e.message
      else
        self.error fatal: e.message, full: e.full_message
      end
    end
  end

end

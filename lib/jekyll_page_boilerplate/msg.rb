
module JekyllPageBoilerplate::Msg

  def self.file name
    puts File.read(File.join(__dir__, 'msg', name))
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
      self.error fatal: e.message
    end
  end

end

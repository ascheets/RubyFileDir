require_relative 'Command'

class CreateFileCommand < Command

  attr_accessor :text
  attr_accessor :file

  def initialize(p,t)
    
    self.description = "Creates a file: #{p}"

    #store path, initText
    self.path = p
    self.text = t

  end

  def execute
    
    if !File.directory? path

      #create file at path with initText    
      file = File.new(path, "w+")
      file.puts text
      file.close

    end

  end

  def undo
    
    #does the file exist?
    if File.exists? path and !File.directory? path
      
      #delete file at path
      File.delete(path)

    end
    
  end
  
end

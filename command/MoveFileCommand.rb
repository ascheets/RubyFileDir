require_relative 'Command'

class MoveFileCommand < Command

  attr_accessor :newLoc
  attr_accessor :text

  def initialize p, n

    self.description = "Move the file #{p} to #{n}"

    self.path = p
    self.newLoc = n

  end

  def execute

    #does the file exist and is it a file?
    if File.exists? path and !File.directory? path
      
      #store the text
      file = File.open(path, "r")
      self.text = file.read

      #delete old file
      File.delete(path)

      #create replica file at new path
      file = File.new(newLoc, "w+")
      file.puts text
      file.close            

    end

  end

  def undo

    #does the file exist and is it a file?
    if File.exists? newLoc and !File.directory? path

      #store the text
      file = File.open(newLoc, "r")
      self.text = file.read

      #delete old file
      File.delete(newLoc)

      #create file at old path
      file = File.new(path, "w+")
      file.puts text
      file.close

    end


  end

    

end

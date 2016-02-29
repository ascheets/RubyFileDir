require_relative 'Command'

class MoveFileCommand < Command

  attr_accessor :newLoc
  attr_accessor :newPath
  attr_accessor :text

  def initialize p, n

    self.description = "Move the file #{p} to #{n}"

    self.path = p
    self.newPath = n

    stop = p.rindex("/")
    n = p.slice(0,stop)
 
    self.newLoc = n

  end

  def execute

    #does the file exist and is it a file?
    if File.exists? path and !File.directory? path and Dir.exist? newLoc

      #store the text
      file = File.open(path, "r")
      self.text = file.read

      #delete old file
      File.delete(path)

      #create replica file at new path
      file = File.new(newPath, "w+")
      file.puts text
      file.close            

    end

  end

  def undo

    #does the file exist and is it a file?
    if File.exists? newLoc and !File.directory? path and !File.directory? newLoc

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

require_relative 'Command'

class MoveFileCommand < Command

  attr_accessor :newLoc
  attr_accessor :oldLoc
  attr_accessor :newPath
  attr_accessor :text

  def initialize p, n

    self.description = "Move the file #{p} to #{n}"

    self.path = p
    self.newPath = n

    #this removes last element of the path
    stop = p.size - p.rindex("/") #add 2 for ./ at beginning
    n = n.slice(0,n.size-stop+1)
 
    self.newLoc = n
    self.oldLoc = path.slice(0,p.rindex("/"))

    #puts "Inside MoveFileCommand"
    #puts "path: " + path
    #puts "newPath: " + newPath
    #puts "newLoc: " + newLoc
    #puts "oldLoc: " + oldLoc

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
    if File.exists? newPath and !File.directory? newPath and Dir.exist? oldLoc

      #store the text
      file = File.open(newPath, "r")
      self.text = file.read

      #delete old file
      File.delete(newPath)

      #create file at old path
      file = File.new(path, "w+")
      file.puts text
      file.close

    end


  end

    

end

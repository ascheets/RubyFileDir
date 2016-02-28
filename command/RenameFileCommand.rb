require_relative 'Command'

class RenameFileCommand < Command

  attr_accessor :newName

  def initialize(p,n)

    self.description = "Renames the file at #{p} to #{n}"

    self.path = p
    self.newName = n

  end

  def execute

    #does the file exist and is it a file?
    if File.exists? path and !File.directory? path

      File.rename(path, newName)

    end


  end

  def undo

    #does the file exist and is it a file?
    if File.exists? newName and !File.directory? newName

      File.rename(newName, path)

    end

  end
  

end

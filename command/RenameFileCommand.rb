require_relative 'Command'

class RenameFileCommand < Command

  attr_accessor :newName

  def initialize(p,n)

    self.description = "Renames the file at #{p} to #{n}"

    

  end

  def execute

    #does the file exist and is it a file?
    if File.exists? path


  end

  def undo


  end
  

end

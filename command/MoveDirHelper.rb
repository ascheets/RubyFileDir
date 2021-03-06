require_relative 'Command'

class MoveDirHelper < Command

  attr_accessor :newPath

  def initialize p, n
    
    self.description = "Directory placeholder for MoveDirectoryCommand, #{p} --> #{n}"

    #store the path
    self.path = p
    self.newPath = n

  end

  def execute

    #use create directory command to create new dir
    c2 = CreateDirectoryCommand.new(newPath)
    c2.execute

  end

  def undo

    #use create directory command to recreate old dir
    c2 = CreateDirectoryCommand.new(path)
    c2.execute

  end



end

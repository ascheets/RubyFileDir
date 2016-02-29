require_relative 'Command'

class MoveDirHelper < Command

  def initialize p, n
    
    self.description = "Directory placeholder for MoveDirectoryCommand, #{p} --> #{n}"

    #store the path
    self.path = p
    self.newPath = n

  end

  def execute

    #use delete directory command to delete old dir
    c1 = DeleteDirectoryCommand.new(path)
    c1.execute
    
    #use create directory command to create new dir
    c2 = CreateDirectoryCommand.new(path)
    c2.execute

  end

  def undo

    #use delete directory command to delete dir
    c1 = DeleteDirectoryCommand.new(newPath)
    c1.execute
    
    #use create directory command to recreate old dir
    c2 = CreateDirectoryCommand.new(path)
    c2.execute

  end



end

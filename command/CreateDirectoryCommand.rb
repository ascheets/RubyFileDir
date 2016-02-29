require_relative 'Command'
require_relative 'DeleteDirectoryCommand'

class CreateDirectoryCommand < Command

  attr_accessor :newLoc
  attr_accessor :newPath

  def initialize(p)

    self.description = "Creates the directory: #{p}"

    #store path, newLocation
    self.path = p
    self.newPath = n

    stop = p.rindex("/")
    n = p.slice(0,stop)

    self.newLoc = n

  end

  def execute
    
    if !Dir.exist? path
      
      Dir.mkdir(path)

    end

  end

  def undo

    c = DeleteDirectoryCommand.new(path)
    c.execute

  end


end

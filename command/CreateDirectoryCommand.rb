require_relative 'Command'
require_relative 'DeleteDirectoryCommand'

class CreateDirectoryCommand < Command

  def initialize(p)

    self.description = "Creates the directory: #{p}"

    #store path
    self.path = p

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

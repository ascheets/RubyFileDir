require_relative 'Command'

class DeleteDirHelper < Command

  def initialize(p)

    self.description = "Directory placeholder for DeleteDirectoryCommand"
    
    #store the path
    self.path = p

  end

  #at this point, the dir should be empty so can just delete
  def execute

    #verify anyway...
    #does the dir exist?
    if Dir.exist? path

      if verify?

        Dir.rmdir(path)

      end

    end

  end

  #at this point, creating dir should be next step, so just create
  def undo

    #just create file at path
    Dir.mkdir(path)
    
  end

end

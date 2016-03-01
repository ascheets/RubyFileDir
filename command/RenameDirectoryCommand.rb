require_relative 'Command'

class RenameDirectoryCommand < Command

  attr_accessor :newName
  attr_accessor :loc

  def initialize(p,n)

    self.description = "Rename the dir #{p} to #{n}"

    self.path = p
    self.newName = n
    
    stop = p.rindex("/")
    self.loc = p.slice(0,stop)

    puts "loc: #{loc}"
    

  end

  def execute

        

  end

  def undo


  end



end

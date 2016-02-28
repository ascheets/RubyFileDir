require_relative 'Command'

class DeleteDirectoryCommand < Command

  attr_accessor :currentPath

  def initialize(p)

    self.description = "Deletes the directory: #{p}"

    #store path
    self.path = p

  end

  def execute

    #call recursive delete on path
    recursiveDelete path

  end

  def undo

    

  end

  def recursiveDelete dir

    Dir.foreach dir do |elem|

      currentPath = dir + "/" +  elem

      puts elem
      puts currentPath

      if elem != "." and elem != ".."

        #if elem is not a dir, must be a file
        if !Dir.exist? currentPath
          #File.delete(currentPath)
          puts "elem is not a dir"
        elsif Dir.entries(currentPath).size <= 2
          #if dir is empty, delete, dir is empty but
          #size is 2 for "." and ".."
          #Dir.rmdir(currentPath)
          puts "removed elem"
        else
          #call recursiveDelete on elem
          recursiveDelete currentPath
          puts "recursion call here"
          
        end
      else
        puts "elem is stupid"
      end

    end

  end


end

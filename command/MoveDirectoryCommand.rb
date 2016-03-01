require_relative 'Command'
#require_relative 'DeleteDirectoryCommand'

class MoveDirectoryCommand < CompositeCommand

  attr_accessor :newLoc
  attr_accessor :newPath
  attr_accessor :oldLoc

  def initialize(p,n)

    super()

    self.description = "Move the dir #{p} to #{n}"

    #store some values
    self.path = p
    self.newPath = n

    #this remove last element of the path; the element actually moving
    stop = p.size - p.rindex("/") + 2 #add 2 for ./ at beginning
    n = n.slice(0,stop)

    #newLoc is path without dir wanting to move
    self.newLoc = n
    self.oldLoc = path.slice(0,p.rindex("/"))

    puts "New location: " + newLoc.to_s
    puts "Old location: " + oldLoc.to_s

    #does the dir exist?
    if Dir.exist? newLoc and Dir.exist? oldLoc

      #this function should make a list of commands that...
      #when executed should move dir through deleting and creating files and dirs
      recursiveMoveDirSetup path

      #MoveDirHelper for original dir
      helper = MoveDirHelper.new(path, newLoc + path.slice(1,path.size-1))
      addCommand helper

    end

  end

  def execute

    #does the dir exist?
    if Dir.exist? newLoc and Dir.exist? path

      #actually moving dir
      #puts "Moving dir #{path}..."
      
      #direction we actually want
      commands.reverse_each do |command|

        #puts command.description
        command.execute


      end

      c = DeleteDirectoryCommand.new(path)
      c.execute
      
    end

  end

  def undo

    #does the dir exist?
    if Dir.exist? newPath and Dir.exist? oldLoc

      #actually moving dir
      puts "Moving dir #{newPath}..."
      puts "oldLoc: #{oldLoc}"
      
      #direction we actually want
      commands.reverse_each do |command|

        puts "inside reverse undo"
        command.description
        command.undo
 
      end

      puts "undo commands all run in reverse order"

      c = DeleteDirectoryCommand.new(newPath)
      c.execute
      
    end
    

  end

  def recursiveMoveDirSetup dir

    #first of all, sort the files from dirs in the directory
    sortedArray = Array.new
    sortedArray = sortFilesFromDirs Dir.entries(dir), dir

    #puts "Paths to be looked at: " + sortedArray.to_s

    #go through dirs then files, compiling composite command
    sortedArray.each do |elem|

      #path of current entity
      currentPath = dir + "/" +  elem

      #puts "elem: " + elem
      #puts "currentPath: " + currentPath

      if elem != "." and elem != ".."

        #if elem is not a dir, must be a file
        if !Dir.exist? currentPath
          #puts "elem is not a dir, create MoveFileCommand, add to commands"
          dfc = MoveFileCommand.new(currentPath, newLoc + currentPath.slice(1,currentPath.size-1))
          addCommand dfc
        elsif Dir.entries(currentPath).size <= 2
          #if dir is empty, delete, dir is empty but
          #size is 2 for "." and ".."
          #puts "Empty dir, create MoveDirHelper, add to commands"
          helper = MoveDirHelper.new(currentPath, newLoc + currentPath.slice(1,currentPath.size-1))
          addCommand helper
        else
          #call recursiveDelete on elem
          #puts "Dir is not empty, jumping in"
          recursiveMoveDirSetup currentPath
          #puts "Just went through dir"
          #puts "Empty dir, create MoveDirHelper, add to commands"
          #puts "Dir: " + currentPath
          helper = MoveDirHelper.new(currentPath, newLoc + currentPath.slice(1,currentPath.size-1))
          addCommand helper
        end
      else
        #puts "Elem is not of interest"
      end

    end

  end

  #this function sorts files from dirs, returning array with
  #dirs first, then files
  def sortFilesFromDirs array, dir #array is elements in current directory: dir

    #temp arrays to hold files vs dirs
    dirs = Array.new
    files = Array.new

    array.each do |elem|

      #path to current entity interested in
      currentPath = dir + "/" + elem
      #puts "currentPath: " + currentPath

      #is dir or no?
      if Dir.exist? currentPath
        dirs << elem
      else
        files << elem
      end

    end

    #return concatenated array
    return dirs + files

  end


end

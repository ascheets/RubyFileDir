require_relative 'Command'

class MoveDirectoryCommand < CompositeCommand

  attr_accessor :newLoc
  attr_accessor :newPath

  def initialize(p,n)

    self.description = "Move the dir #{p} to #{n}"

    #store some values
    self.path = p
    self.newPath = n

    stop = p.rindex("/")
    n = p.slice(0,stop)

    #newLoc is path without dir wanting to move
    self.newLoc = n

  end

  def execute

    #does the dir exist?
    if Dir.exist? newLoc

      traverseDirTopBottom path do |elem|
        
        

      end

    end


  end

  def traverseDirTopBottom dir

    #puts "Current path: " + dir

    sortedArray = Array.new
    #first of all, sort the files from dirs in the directory
    sortedArray = sortFilesFromDirs Dir.entries(dir), dir

    #puts "Array of objects in dir: " + Dir.entries(dir).to_s

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
          #puts "elem is not a dir, create DeleteFileCommand, add to commands"
          dfc = MoveFileCommand.new(currentPath, newLoc + currentPath)
          addCommand dfc
        elsif Dir.entries(currentPath).size <= 2
          #if dir is empty, delete, dir is empty but
          #size is 2 for "." and ".."
          #puts "Empty dir, create DeleteDirHelper, add to commands"
          helper = MoveDirHelper.new(currentPath, newLoc + currentPath)
          addCommand helper
        else
          #call recursiveDelete on elem
          #puts "Dir is not empty, jumping in"
          recursiveDeleteSetup currentPath
          #puts "Just went through dir"
          #puts "Empty dir, create DeleteDirHelper, add to commands"
          #puts "Dir: " + currentPath
          helper = MoveDirHelper.new(currentPath, newLoc + currentPath)
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

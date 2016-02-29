require_relative 'Command'
require_relative 'CompositeCommand'
require_relative 'DeleteFileCommand'
require_relative 'DeleteDirHelper'

class DeleteDirectoryCommand < Command::CompositeCommand

  attr_accessor :currentPath

  def initialize(p)

    self.description = "Deletes the directory: #{p}"

    #store path
    self.path = p

  end

  def execute

    #call recursive delete on path
    recursiveDeleteSetup path

  end

  def undo

    

  end

  def recursiveDeleteSetup dir

    puts "Current path: " + dir

    sortedArray = Array.new
    #first of all, sort the files from dirs in the directory
    sortedArray = sortFilesFromDirs Dir.entries(dir), dir

    #puts "Array of objects in dir: " + Dir.entries(dir).to_s

    puts "Paths to be looked at: " + sortedArray.to_s

    #go through dirs then files, compiling composite command
    sortedArray.each do |elem|

      #path of current entity
      currentPath = dir + "/" +  elem

      puts "elem: " + elem
      puts "currentPath: " + currentPath

      if elem != "." and elem != ".."

        #if elem is not a dir, must be a file
        if !Dir.exist? currentPath
          #File.delete(currentPath)
          puts "elem is not a dir, create DeleteFileCommand, add to commands"
          dfc = DeleteFileCommand.new(currentPath)
          puts dfc.to_s
          #addCommand dfc
        elsif Dir.entries(currentPath).size <= 2
          #if dir is empty, delete, dir is empty but
          #size is 2 for "." and ".."
          puts "Empty dir, create DeleteDirHelper, add to commands"
          helper = DeleteDirHelper.new(currentPath)
          puts helper.to_s
          #addCommand helper
        else
          #call recursiveDelete on elem
          puts "Dir is not empty, jumping in"
          recursiveDeleteSetup currentPath
        end
      else
        puts "Elem is not of interest"
      end

    end

    #description

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

    #puts "dirs: " + dirs.to_s
    #puts "files: " + files.to_s
    
    #return concatenated array
    return dirs + files

  end


end

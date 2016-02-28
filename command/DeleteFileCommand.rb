require_relative 'Command'

class DeleteFileCommand < Command

  attr_accessor :text

  def initialize(p)

    self.description = "Deletes the file #{p}"

    #store the path
    self.path = p

  end

  def execute

    #does the file exist?
    if File.exists? path and !File.directory? path

      if verify?

        file = File.open(path, "r")
        text = file.read
        File.delete(path)
        puts "Delete file at #{path}"

      end

    end

  end

  def undo

    if !File.directory? path
      
      file = File.new(path, "w+")
      file.puts text
      file.close

    end

  end

end

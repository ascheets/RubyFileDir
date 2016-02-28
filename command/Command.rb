class Command

  attr_accessor :description
  attr_accessor :path


  def initialize()

  end

  def execute

  end

  def undo

  end

  def verify?

    puts "Are you sure you want to delete this? (y/n)"
    verify = gets
    verify.chomp!

    if verify == "y" or verify == "Y"
      return true
    else
      return false
    end

  end

end

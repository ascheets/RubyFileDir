require_relative 'Command'

class CompositeCommand < Command

  attr_accessor :commands

  def initialize

    self.commands = Array.new
    commandPosition = 0

  end

  def execute

    commands.each do |command|
      
      command.execute

    end

  end

  def undo


  end

  def stepForward


  end

  def stepBackward


  end
  
  def addCommand c

    self.commands << c

  end

  def description

    commands.each do |command|

      puts command.description

    end

  end


end

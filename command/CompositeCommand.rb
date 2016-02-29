require_relative 'Command'

class CompositeCommand < Command

  attr_accessor :commands
  attr_accessor :commandPosition

  def initialize

    self.commands = Array.new
    
    #commandPosition is one in front of the last command to have been executed
    #so when at zero, none have been executed or all have been undone
    self.commandPosition = 0

  end

  def execute

    commands.each do |command|
      
      command.execute

    end

    self.commandPosition = (commands.size) - 1

  end

  def undo

    #get sub array in case not all commands have been executed
    commandsSub = commands[0,commandPosition+1]

    commandsSub.each do |command|

      command.undo

    end

    self.commandPosition = 0

  end

  def stepForward i

    if commandPosition != commands.size

      commands[commandPosition].execute
      
      self.commandPosition += 1

    end

  end

  def stepBackward i

    if commandPosition != 0
      
      commands[commandPosition-1].execute

      self.commandPosition -= 1

    end

  end
  
  def addCommand c
    
    #puts "Inside addCommand: " +  c.to_s 
    #puts "Commands: " + self.commands.to_s
    
    self.commands << c

  end

  def description

    commands.each do |command|

      puts command.description

    end

  end


end

#include all the class rb files
Dir["./command/*.rb"].each { |file| require_relative file}

#create a composite command

cc = CompositeCommand.new

#create some commands
c1 = CreateFileCommand.new("./test", "Hello world, dirp")
c2 = DeleteFileCommand.new("./test")
c3 = CreateFileCommand.new("./test", "hello")
c4 = RenameFileCommand.new("./test", "./cheese")
c5 = MoveFileCommand.new("./cheese", "./testing/whoops/cheese")

cc.addCommand(c1)
cc.addCommand(c2)
cc.addCommand(c3)
cc.addCommand(c4)
cc.addCommand(c5)

puts cc.description

cc.execute
cc.undo


cc.stepForward(2)

cc.stepBackward(1)

cc.stepForward(3)



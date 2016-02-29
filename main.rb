#include all the class rb files
Dir["./command/*.rb"].each { |file| require_relative file}

#create a composite command

cc = CompositeCommand.new

#create some commands
c0 = CreateDirCommand.new("./testing")
c1 = CreateFileCommand.new("./testing/test", "Hello world, dirp")
c2 = DeleteFileCommand.new("./test")
c3 = CreateFileCommand.new("./testing/test2", "hello")
c4 = RenameFileCommand.new("./testing/test2", "./testing/cheese")
c5 = MoveFileCommand.new("./testing/cheese", "./testing/whoops/cheese")

c6 = DeleteDirectoryCommand.new("./testing")
c6.execute
c6.undo

cc.addCommand(c1)
cc.addCommand(c2)
cc.addCommand(c3)
cc.addCommand(c4)
cc.addCommand(c5)

# puts cc.description

cc.execute
# cc.undo


# cc.stepForward(2)

# cc.stepBackward(1)

# cc.stepForward(3)



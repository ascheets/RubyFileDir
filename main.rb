#include all the class rb files
Dir["./command/*.rb"].each { |file| require_relative file}

c = CreateFileCommand.new("./test", "Hello world, dirp")
c2 = DeleteFileCommand.new("./testing")
c21 = CreateFileCommand.new("./testing", "hello")
c3 = RenameFileCommand.new("./test", "./testing")
c4 = MoveFileCommand.new("./testing", "./testing/whoops")
c5 = CreateDirectoryCommand.new("./whatup")
c6 = DeleteDirectoryCommand.new("./tired")

puts c.description
puts c2.description
puts c3.description
puts c4.description
puts c5.description
puts c6.description

c.execute
c21.execute
c2.execute
c2.undo
c3.execute
c3.undo
c.undo
c4.execute
c4.undo
c5.execute
c5.undo
c6.execute
c6.undo

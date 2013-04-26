$:.push File.expand_path("../../lib", __FILE__)

require 'locked_process'

file    = '/tmp/locked_process_test_file.txt'
pidfile = '/tmp/locked_process_test_file_pid.pid'

File.unlink(file) if File.exists?(file)
#File.unlink(pidfile) if File.exists?(pidfile)

process = LockedProcess.new(pidfile) do
  sleep 2
  File.open(file, 'w').close
  sleep 2
end

process.execute
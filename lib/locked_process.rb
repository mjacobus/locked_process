require 'thread'

class LockedProcess
  VERSION = '0.0.1'

  class Error < StandardError; end

  attr_reader :pid_file

  def initialize(pid_file)
    unless block_given?
      raise ArgumentError.new('Block must be given')
    end

    @process = lambda { yield }
    @pid_file = pid_file
  end

  def pid_file_exists?
    File.exists?(pid_file)
  end

  def execute
    create_pid_file
    Thread.new do
      @process.call
      remove_pid_file
    end
  end

  private
    def create_pid_file
      if pid_file_exists?
        raise Error.new("Process is already running (pidfile '#{pid_file}' exists)")
      end
      File.open(pid_file, 'w').close
    end

    def remove_pid_file
      File.unlink(pid_file)
    end
end
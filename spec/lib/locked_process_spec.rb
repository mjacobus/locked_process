require 'spec_helper'

describe LockedProcess do
  before do
    system("rm -f #{pidfile}")
    system("rm -f #{test_file}")
  end

  after do
    system("rm -f #{pidfile}")
    system("rm -f #{test_file}")
  end

  let(:mocked) { mock(:mocked, run: 'running') }
  let(:pidfile) { '/tmp/locked_process_spec.pid' }
  let(:test_file) { '/tmp/locked_process_test_file.pid' }

  subject do
    LockedProcess.new(pidfile) do
      mocked.run('abc')
    end
  end


  describe "#initialize" do
    context "when block is not given" do
      it "raises ArgumentError" do
        expect { LockedProcess.new(pidfile) }.to raise_error(ArgumentError, 'Block must be given')
      end
    end
  end

  describe "#execute" do
    it "creates a pid file" do
      subject.execute
      File.exists?(pidfile).should be_true
    end

    it "raises an exception when file exists" do
      subject.stub(:pid_file_exists?).and_return(true)
      expect { subject.execute }.to raise_error(LockedProcess::Error, "Process is already running (pidfile '#{pidfile}' exists)")
    end

    it "executes the code in a thread and removes the pid file" do
      process = LockedProcess.new(pidfile) do
        sleep(0.1)
        File.open(test_file, 'w').close
      end

      process.execute

      File.exists?(test_file).should be_false
      File.exists?(pidfile).should be_true
      sleep(0.2)
      File.exists?(test_file).should be_true
      File.exists?(pidfile).should be_false
    end

    it "executes even if the main process is gone down" do
      process = LockedProcess.new(pidfile) do
        sleep(0.1)
        File.open(test_file, 'w').close
      end

      process.execute

      fork do
        exit
      end

      File.exists?(test_file).should be_false
      File.exists?(pidfile).should be_true
      sleep(0.2)
      File.exists?(test_file).should be_true
      File.exists?(pidfile).should be_false

    end
  end

  describe "#pid_file_exists?" do
    it "checks whether pid file exists" do
      subject.pid_file_exists?.should be_false
      system("touch #{pidfile}")
      subject.pid_file_exists?.should be_true
    end
  end

end
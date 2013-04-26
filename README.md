# LockedProcess
Locked process is a way of executing a Thread but preventing the same Thread from being executed while the first one is still running.

## Instalation
```bash
gem install 'locked_process'
```

## Usage
```ruby
require 'locked_process'

process = LockedProcess.new('/tmp/download_images.pid') do
  MyImageDownloader.new.download
end

process.execute # executes MyImageDownloader.new.download in a Thread

# if the process is still running
process.execute # raises LockedProcess::Error

```


## Author
Marcelo Jacobus
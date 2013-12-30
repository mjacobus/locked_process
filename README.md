# LockedProcess

[![Build Status](https://travis-ci.org/mjacobus/locked_process.png?branch=master)](https://travis-ci.org/mjacobus/locked_process)
[![Coverage Status](https://coveralls.io/repos/mjacobus/locked_process/badge.png)](https://coveralls.io/r/mjacobus/locked_process)
[![Code Climate](https://codeclimate.com/github/mjacobus/locked_process.png)](https://codeclimate.com/github/mjacobus/locked_process)
[![Dependency Status](https://gemnasium.com/mjacobus/locked_process.png)](https://gemnasium.com/mjacobus/locked_process)
[![Gem Version](https://badge.fury.io/rb/locked_process.png)](http://badge.fury.io/rb/locked_process)

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
- [Marcelo Jacobus](https://github.com/mjacobus)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
**Do not forget to write tests**
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


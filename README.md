[![codebeat badge](https://codebeat.co/badges/b4067adc-06cb-4142-a985-519555be3070)](https://codebeat.co/projects/github-com-akabiru-hscode) [![Dependency Status](https://gemnasium.com/badges/github.com/akabiru/hscode.svg)](https://gemnasium.com/github.com/akabiru/hscode) [![Inline docs](http://inch-ci.org/github/akabiru/hscode.svg?branch=master)](http://inch-ci.org/github/akabiru/hscode) [![Coverage Status](https://coveralls.io/repos/github/akabiru/hscode/badge.svg?branch=master)](https://coveralls.io/github/akabiru/hscode?branch=master) [![Build Status](https://travis-ci.org/akabiru/hscode.svg?branch=master)](https://travis-ci.org/akabiru/hscode) [![Gem Version](https://badge.fury.io/rb/hscode.svg)](https://badge.fury.io/rb/hscode)

# Hscode

Hscode is a simple `HTTP` status code lookup tool. Lookup that status code at the comfort of your own terminal.😎

## Installation

Install it yourself as:

    $ gem install hscode

Or Add this line to your application's Gemfile:

```ruby
gem 'hscode'
```

And then execute:

    $ bundle

## Usage

Run a quick lookup

    $ hscode -c 200

For a more comprehensive description, run verbosely.

    $ hscode -c 200 -v

List all status codes

    $ hscode -l

In case you forget something; run help.

    $ hscode -h


## Screencast
[![asciicast](https://asciinema.org/a/9vjzetmxefd86dxymbr969et2.png)](https://asciinema.org/a/9vjzetmxefd86dxymbr969et2)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/akabiru/hscode. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


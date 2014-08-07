# RakeITask

This gem provided a rake taks named 'i' making rake interactive:


it opens a REPL shell with the following commands

  * *help* - provide help
  * *rake* - perform rake tasks
  * *exit* - leave the hell

It provides

  * TAB completion for the rake tasks
  * History even across sessions

## Installation

Add this line to your application's Gemfile:

    gem 'rake_i_task'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rake_i_task

## Usage

add the following line to your rake file

  require 'rake_i_task'

you then can run 

    rake i

## credits

 * https://github.com/exploid/rake-repl
 * http://stackoverflow.com/a/22545297/2092206

## license 

MIT

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


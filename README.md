# Gemologist

## A specialist in gems.

This is a self-hosted tool to check if your Ruby gems dependencies are up-to-date.

## Installation

    $ git clone https://github.com/jodosha/gemologist.git
    $ cd gemologist && bundle

## Usage

Gemologist has two components: the resolver and the web app.

### Resolver

It's database-less, that means the only way to add a repository is via command line:

    $ bundle exec bin/gemologist add foo https://github.com/jodosha/foo.git

It creates a `foo` directory under `repositories` and checks if its dependencies are out of date.

In order to check the status of all the repositories run:

    $ bundle exec bin/gemologist

Pheraps you may want to use UNIX Cron for this.

### Web App

It's a Sinatra wep app to run it just use:

    $ rackup config.ru

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

2012 [Luca Guidi](http://lucaguidi.com) – Released under the MIT License

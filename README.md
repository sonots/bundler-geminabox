# Bundler::Geminabox

This gem provides `rake geminabox_release` command to release gem on internal rubygems server such as [geminabox](https://github.com/geminabox/geminabox),
and disable `rake release` command for foolproof. 

## Installation

Add following to your Gemfile:

```
gem 'bundler-geminabox'
```

And then execute:

```
$ bundle
```

## Usage

### How to release a gem

Modify Rakefile as:

```diff
- require "bundler/gem_tasks"
+ require "bundler/geminabox/gem_tasks"
```

Run following to release your gem to your internal rubygems server:

```
GEMINABOX=https://your.rubygems.org bundle exec rake geminabox_release
```

Note that `rake release` is disabled not to release to rubygems.org mistakenly.

### How to fetch gems from your.rubygems.jp

Write your application's Gemfile as:

```ruby
source 'https://your.rubygems.org'

gem 'your_awesome_geminabox_gem'
```

And then execute:

    $ bundle

### How to create a new gem

This gem also provides a command to create a skelton for a new gem to be released to https://your.rubygems.org

Run

```
GEMINABOX=https://your.rubygems.org bundle-geminabox gem GEM
```

instead of

```
bundle gem GEM
```

Example:

```
$ GEMINABOX=https://your.rubygems.org bundle-geminabox gem foo
      create  foo/Gemfile
      create  foo/.gitignore
      create  foo/lib/foo.rb
      create  foo/lib/foo/version.rb
      create  foo/LICENSE.txt
      create  foo/foo.gemspec
      create  foo/.consolerc
      create  foo/Rakefile
      create  foo/README.md
       force  foo/Gemfile
       force  foo/Rakefile
```

Note that `Gemfile` and `Rakefile` are updated.

## FAQ

#### Does this gem work with only geminabox?

No. `bundler-geminabox` works with any internal rubygems compatible servers. 
The name is just because I am using geminabox. 

#### I hate to type GEMINABOX everytime. Any good ways?

There are two ways.

1 . Just write following to your .bashrc:

```
export GEMINABOX=https://your.rubygems.org
```

2 . Create your own private wrapper specific to your enviroment

Here is a skelton https://github.com/sonots/bundler-foo.

The point is to prepare your own lib/bundler/foo/config.rb as:

```
require 'bundler/geminabox/config'
Bundler::Geminabox::Config.geminabox = 'https://rubygems.foo.jp'
Bundler::Geminabox::Config.gem_tasks = 'bundler/foo/gem_tasks'
Bundler::Geminabox::Config.release_task = 'foo_release'
```

As this shows, you can also customize `rake geminabox_release` command to your favorite `rake foo_release` command in this way. 

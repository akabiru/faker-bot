# FakerBot

[![codebeat badge](https://codebeat.co/badges/ef4839f2-3946-4435-8c0e-7025de5fac22)](https://codebeat.co/projects/github-com-akabiru-fakerbot-master) [![Inline docs](http://inch-ci.org/github/akabiru/fakerbot.svg?branch=master)](http://inch-ci.org/github/akabiru/fakerbot) [![Build Status](https://travis-ci.com/akabiru/fakerbot.svg?branch=master)](https://travis-ci.com/akabiru/fakerbot) [![Coverage Status](https://coveralls.io/repos/github/akabiru/fakerbot/badge.svg?branch=master)](https://coveralls.io/github/akabiru/fakerbot?branch=master) [![Gem Version](https://badge.fury.io/rb/fakerbot.svg)](https://badge.fury.io/rb/fakerbot)

> Quickly look up [Faker](https://github.com/stympy/faker) methods without leaving your terminal!

## Motivation

I'm a huge fan of the [Faker Gem](https://github.com/stympy/faker) and use it everywhere. However, sometimes I find myself digging through Faker's ReadMe when I'm unsure of a method's namespace
or I'm just not sure what's available. :see_no_evil: I've always wished I had some way to search for the method names without leaving my terminal.


## Installation

```bash
$ gem install fakerbot
```

## Usage

Run a quick lookup

```bash
$ fakerbot search name
# Faker::SwordArtOnline
# └── real_name
# └── game_name
# Faker::Superhero
# └── name
# Faker::ProgrammingLanguage
# └── name
# Faker::Cat
# └── name
# Faker::Pokemon
# └── name
# e.t.c
```

## New Features! :sunglasses: :dancers:

- [x] List classes with methods E.g. Faker::FunnyName should list `.name`,`.first_name` e.t.c.
- [x] Expand search to Faker::Base sub classes i.e."fakerbot search email" should include `Faker::Internet.email`

![screen shot 2018-08-09 at 20 21 06](https://user-images.githubusercontent.com/17295175/43914887-c9a99d84-9c11-11e8-9686-85f584412b27.jpg)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/akabiru/fakerbot. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FakerBot project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/akabiru/fakerbot/blob/master/CODE_OF_CONDUCT.md).

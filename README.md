# FakerBot

[![codebeat badge](https://codebeat.co/badges/ef4839f2-3946-4435-8c0e-7025de5fac22)](https://codebeat.co/projects/github-com-akabiru-faker_bot-master) [![Inline docs](http://inch-ci.org/github/akabiru/faker_bot.svg?branch=master)](http://inch-ci.org/github/akabiru/faker_bot) [![Build Status](https://travis-ci.com/akabiru/faker_bot.svg?branch=master)](https://travis-ci.com/akabiru/faker_bot) [![Coverage Status](https://coveralls.io/repos/github/akabiru/faker_bot/badge.svg?branch=master)](https://coveralls.io/github/akabiru/faker_bot?branch=master) [![Gem Version](https://badge.fury.io/rb/fakerbot.svg)](https://badge.fury.io/rb/fakerbot)

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
# Faker::FunnyName
# Faker::Name
```

## TODO

- [ ] List classes with methods E.g. Faker::FunnyName should list `.name`,`.first_name` e.t.c.
- [ ] Expand search to Faker::Base sub classes i.e."fakerbot search email" should include `Faker::Internet.email`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/akabiru/faker_bot. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FakerBot project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/akabiru/faker_bot/blob/master/CODE_OF_CONDUCT.md).

# faker-bot

[![Build Status](https://travis-ci.org/faker-ruby/faker-bot.svg?branch=master)](https://travis-ci.org/faker-ruby/faker-bot)
[![Gem Version](https://badge.fury.io/rb/faker-bot.svg)](https://badge.fury.io/rb/faker-bot)
[![Open Source Helpers](https://www.codetriage.com/faker-ruby/faker-bot/badges/users.svg)](https://www.codetriage.com/faker-ruby/faker-bot)
[![Maintainability](https://api.codeclimate.com/v1/badges/f40541168a0fafbe1808/maintainability)](https://codeclimate.com/github/faker-ruby/faker-bot/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/f40541168a0fafbe1808/test_coverage)](https://codeclimate.com/github/faker-ruby/faker-bot/test_coverage)

> Quickly look up [Faker](https://github.com/faker-ruby/faker) methods without leaving your terminal!

![faker-bot-demo](https://user-images.githubusercontent.com/17295175/62558993-c57be080-b882-11e9-972e-7588408d45c3.gif)

:book: [Code Documentation](https://www.rubydoc.info/github/faker-ruby/faker-bot)

## Installation

```bash
$ gem install faker-bot
```

## Usage

1.) Run a quick lookup

```bash
$ faker search name
# Faker::SwordArtOnline
# └── real_name
# └── game_name
# Faker::Superhero
# └── name
# ....
```

2.) List methods

```sh
$ faker list
# Faker::BackToTheFuture
# ├── quote
# ├── date
# └── character
# Faker::Finance
# └── credit_card
# ....
```

`faker` also includes an option to display sample output via the `--verbose` or `-v` flag. :wink:

3.)

```sh
$ faker list -v
# Faker::Appliance
# ├── brand=> Whirlpool
# └── equipment=> Sump pump
# Faker::UmphreysMcgee
# └── song=> Headphones & Snowcones
$ faker search name -v
# Faker::App
# └── name=> Subin
# Faker::Address
# └── street_name=> Percy Landing
# ....
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/faker-ruby/faker-bot. See [CONTRIBUTING.md](https://github.com/faker-ruby/faker-bot/blob/master/CONTRIBUTING.md).
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Credits

Terminal awesomeness made easy by the [TTY Toolkit](http://piotrmurach.github.io/tty/). :beer:

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the faker-bot project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/faker-ruby/faker-bot/blob/master/CODE_OF_CONDUCT.md).

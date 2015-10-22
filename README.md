# Arbolito

Arbolito is a minimalist  ruby API for currency conversions, it has no dependencies except the Ruby Standard Library

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'arbolito'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install arbolito

## Features
  * Doesn't encapsulates the currencies in any object model, it just use `BigDecimal` class and `Hash`
  * You can add manually price rates 
  * If the rate isn't found it fetches the rate using Yahoo Finance API as exchange
  * You implement your own exchange and configure it
  * It stores in memory the rates fetched with a configurable expiration time
  * You can implement your own store and configure it

## Motivation
There were two reason why I've developed this gem. 

First the argetine economy makes difficult to keep the prices updated with official exchanges rates like Yahoo Finance, so we had to manage our own prices rates. But also I wanted to know the rates of other currencies through Yahoo Finance. This gem lets you do both. 

The second reason is that other gems implements their own money or currency model, and I didn't want to update all my models to manage those objects. That's why I tried to be agnostic on how you implement your currencies. 

The API just receives a Big Decimal and a hash describing the conversion

## Usage

``` ruby 
require 'arbolito'

# We can add multiple rates

Arbolito.add_currency_rate(BigDecimal.new(9), 'USD' => 'ARS')
Arbolito.add_currency_rate(BigDecimal.new(15), 'USD Blue' => 'ARS')
Arbolito.add_currency_rate(BigDecimal.new(12), 'USD Tarjeta' => 'ARS')
Arbolito.add_currency_rate(BigDecimal.new(6.5), 'USD Moreno' => 'ARS')

# It gives the stored rate
Arbolito.current_rate('USD' => 'ARS')
# => #<BigDecimal:7f061f0787e0,'0.15E2',9(27)>

# It stored rate backwards
Arbolito.current_rate('ARS' => 'USD')
# => #<BigDecimal:7f061f076af8,'0.6666666666 6666667E-1',18(36)>

# It can make the conversion for you
Arbolito.convert(BigDecimal.new(100), 'USD' => 'ARS')
# => #<BigDecimal:7f061f1bd010,'0.15E4',9(27)>

Arbolito.convert(BigDecimal.new(100), 'USD Tarjeta' => 'ARS')
=> #<BigDecimal:7f061f39c818,'0.12E4',9(27)>

# Now we ask for the Uruguayan pesos to USD rate
Arbolito.current_rate('UYU' => 'USD')
#<BigDecimal:7f061f142ba8,'0.34E-1',9(18)>

# Now we ask to convert USD to Chilean Pesos
Arbolito.convert(BigDecimal.new(100), 'USD' => 'CLP')
=> #<BigDecimal:7f061f35e680,'0.689695E5',18(36)>

```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jvillarjeo/arbolito. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


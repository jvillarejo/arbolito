require 'bigdecimal'
require 'arbolito/currency/quote'
require 'arbolito/currency/rate'
require 'arbolito/exchange/yahoo_finance'
require "arbolito/version"

module Arbolito

  class << self
    def add_currency_rate(currency_price, from_to_currencies)
      rate = Currency::Rate.new(currency_price, from_to_currencies) 
      add_to_store(rate)
    end

    def current_rate(from_to_currencies) 
      store[Currency::Quote.new(from_to_currencies).to_hash].price
    end

    def convert(money, from_to_currencies)
      quote = Currency::Quote.new(from_to_currencies)

      store[quote.to_hash].convert(money)
    end

    def exchange=(exchange)
      @@exchange = exchange
    end

    private
    def add_to_store(rate)
      store[rate.quote.to_hash] = rate
        
      backwards_rate = rate.backwards
      store[backwards_rate.quote.to_hash] = backwards_rate
    end

    def store
      @@store ||= {}
    end

    def exchange
      @@exchange = Exchange::YahooFinance.new
    end
  end
end

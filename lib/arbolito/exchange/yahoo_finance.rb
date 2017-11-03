require 'net/http'

module Arbolito
  module Exchange
    class YahooFinance
      class << self
        # DEPRECATED Yahoo Finance is not supported anymore by Yahoo so use Alpha Vantage API
        def find_current_rate(quote)
          warn "[DEPRECATION] Yahoo Finance `find_current_rate` is deprecated.  Please use AlphaVantage `find_current_rate` instead."
          data = response(build_uri(quote))

          values = {
            quote: quote,
            price: data[1],
          }

          build_rate(values)
        end

        private
        def response(uri)
          response = Net::HTTP.get(uri)
          data = response.gsub(/"|\\n/,'').split(',')
        end

        def build_uri(quote)
          param = "#{quote.from.upcase}#{quote.to.upcase}"
          URI("http://download.finance.yahoo.com/d/quotes.csv?s=#{param}=X&f=nl1d1t1")
        end

        def build_rate(values)
          Currency::Rate.new(
            values[:price],
            values[:quote].to_hash
          )
        end
      end
    end
  end
end
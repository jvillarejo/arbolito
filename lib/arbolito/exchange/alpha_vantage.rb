require 'net/http'
require 'json'

module Arbolito
  module Exchange
    class AlphaVantage
      BaseURL = 'https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=%s&to_currency=%s&apikey=%s'.freeze

      attr_reader :api_key

      def initialize(api_key)
        @api_key = api_key
      end

      def find_current_rate(quote)
        data = response(build_uri(quote.from,quote.to))
        rated_at_str = "#{data['6. Last Refreshed']} #{data['7. Time Zone']}"
        rated_at = Time.strptime(rated_at_str,'%Y-%m-%d %H:%M:%S %Z')

        values = { 
          quote: quote.to_hash,
          price: data['5. Exchange Rate'],
          rated_at: rated_at.localtime
        }

        Currency::Rate.new(
            values[:price],
            values[:quote].to_hash,
            values[:rated_at]
        )
      end

      def response(uri)
        response = Net::HTTP.get(uri)
        json = JSON.parse(response)
        json['Realtime Currency Exchange Rate']
      end

      def build_uri(from, to)
        url = BaseURL % [from.upcase, to.upcase, api_key]
        URI(url)
      end
    end
  end
end

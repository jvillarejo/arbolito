module Arbolito
  module Currency
    class Rate
      attr_reader :quote, :price

      def initialize(price, from_to_hash)
        @quote = Quote.new(from_to_hash)
        @price = BigDecimal.new(price)
      end

      def convert(money)
        @price * BigDecimal.new(money)
      end
      
      def backwards
        Rate.new(BigDecimal.new(1) / @price, @quote.backwards.to_hash)
      end

      def ==(other_currency_rate)
        raise TypeError unless other_currency_rate.is_a?(CurrencyRate)

        @quote == other_currency_rate.quote && @price == @other.price
      end
    end
  end
end
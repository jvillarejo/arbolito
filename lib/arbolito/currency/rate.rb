module Arbolito
  module Currency
    class Rate
      attr_reader :quote, :price, :rated_at

      def initialize(price, from_to_hash, rated_at = Time.now)
        @quote = Quote.new(from_to_hash)
        @price = BigDecimal.new(price)
        @rated_at = rated_at
      end

      def convert(money)
        @price * BigDecimal.new(money)
      end

      def backwards
        self.class.new(BigDecimal.new(1) / @price, @quote.backwards.to_hash)
      end

      def expired?(expiration_time)
        (Time.now - rated_at) > expiration_time
      end

      def ==(other_currency_rate)
        raise TypeError unless other_currency_rate.is_a?(CurrencyRate)

        @quote == other_currency_rate.quote && @price == @other.price
      end
    end
  end
end
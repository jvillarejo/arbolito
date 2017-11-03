module Arbolito
  module Exchange
    class Spy
      attr_reader :times_called

      def initialize
        @times_called = 0
      end

      def find_current_rate(quote)
        @times_called += 1
        Arbolito::Currency::Rate.new(BigDecimal.new(15), quote.to_hash)
      end
    end
  end
end
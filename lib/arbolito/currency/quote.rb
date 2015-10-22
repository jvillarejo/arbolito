module Arbolito
  module Currency
    class Quote
      attr_reader :from, :to
      
      def initialize(hash) 
        raise ArgumentError.new('You must specify 1 quote rate') if hash.size != 1

        @from = hash.keys.first.to_sym
        @to = hash.values.first.to_sym
      end

      def to_hash
        { @from => @to }
      end

      def backwards 
        Quote.new( @to => @from )
      end

      def ==(other_currency_quote)
        raise TypeError unless other_currency_quote.is_a?(Quote)

        @from == other_currency_quote.from && @to == other_currency_quote.to
      end
    end
  end
end
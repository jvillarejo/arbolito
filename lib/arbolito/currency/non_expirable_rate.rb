module Arbolito
  module Currency
    class NonExpirableRate < Rate
      def expired?(expiration_time)
        false
      end
    end
  end
end
module Arbolito
  module Store
    class Memory
      class << self
        def mutex
          @@mutex ||= Mutex.new
        end

        def add(rate)
          synchronize do 
            hash[rate.quote.to_hash] = rate
          end
        end

        def fetch(quote)
          synchronize do 
            hash[quote.to_hash]
          end
        end

        def synchronize(&block)
          mutex.synchronize(&block)
        end

        def hash
          @@hash ||= {}
        end
      end
    end
  end
end
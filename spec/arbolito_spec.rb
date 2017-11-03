require 'spec_helper'

describe Arbolito do
  it 'has a version number' do
    expect(Arbolito::VERSION).not_to be nil
  end

  describe 'adding a currency rate manually' do
    before { Arbolito.add_currency_rate(BigDecimal.new(15), 'USD' => 'ARS') }
  
    it 'lets you add fixed currency quotes' do
      expect(Arbolito.current_rate('USD' => 'ARS')).to eq(BigDecimal.new(15))
    end

    it 'gives you the backward currency rate' do 
      expect(Arbolito.current_rate('ARS' => 'USD')).to eq(BigDecimal.new(1) / BigDecimal.new(15))
    end

    it 'can convert the money with the current currency rate' do
      expect(Arbolito.convert(BigDecimal.new(100), 'USD' => 'ARS')).to eq(BigDecimal.new(1500))
    end

    it 'can convert the money backwards with the current currency rate' do
      expect(Arbolito.convert(BigDecimal.new(1500), 'ARS' => 'USD')).to eq(BigDecimal.new(1500) * (BigDecimal.new(1) / BigDecimal.new(15)))
    end
  end

  describe 'configuring arbolito' do 
    it 'can set the expiration time' do 
      Arbolito.set(:expiration_time, 24*60*60)

      expect(Arbolito.settings[:expiration_time]).to eq(24*60*60)
    end

    it 'can set the exchange' do 
      Arbolito.set(:exchange, Arbolito::Exchange::YahooFinance)
      
      expect(Arbolito.settings[:exchange]).to eq(Arbolito::Exchange::YahooFinance)
    end

    it 'can set the exchange with api key' do 
      Arbolito.set(:exchange, Arbolito::Exchange::AlphaVantage.new('asfakshfjkashfj')) 

      expect(Arbolito.settings[:exchange]).to be_a(Arbolito::Exchange::AlphaVantage)
      expect(Arbolito.settings[:exchange].api_key).to eq('asfakshfjkashfj')
    end

    it 'can set the store' do 
      Arbolito.set(:store, Arbolito::Store::Memory)

      expect(Arbolito.settings[:store]).to eq(Arbolito::Store::Memory)
    end
  end

  describe 'fetching for the currency rate remotely' do 
    it 'can give you the currency rate using alpha vantage api' do 
      Arbolito.set(:exchange, Arbolito::Exchange::AlphaVantage.new(ENV['ALPHA_VANTAGE_API_KEY'])) 

      price = Arbolito.current_rate('USD' => 'UYU')

      expect(price).to be_instance_of(BigDecimal)
      expect(price).to be > 0
    end

    context 'when setting an expiration time' do 
      let(:spy) { Arbolito::Exchange::Spy.new }
      
      before do 
        Arbolito.set(:expiration_time,5)
        Arbolito.set(:exchange, spy)
      end

      it 'retrieves the same rate when time hasn\'t expired' do 
        Arbolito.current_rate('USD' => 'ARS')
        Arbolito.current_rate('USD' => 'ARS')

        expect(spy.times_called).to eq(1)
      end

      it 'fetches a new rate when time expired' do 
        Arbolito.current_rate('USD' => 'ARS')
        sleep(6)
        
        Arbolito.current_rate('USD' => 'ARS')

        expect(spy.times_called).to eq(2)
      end
    end
  end

  
end

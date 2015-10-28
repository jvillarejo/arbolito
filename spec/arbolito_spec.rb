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

  describe 'fetching for the currency rate remotely' do 
    it 'can give you the currency rate using yahoo finance api' do 
      price = Arbolito.current_rate('USD' => 'UYU')

      expect(price).to be_instance_of(BigDecimal)
      expect(price).to be > 0
    end

    context 'when setting an expiration time' do 
      before do 
        Arbolito.expiration_time = 5
      end

      it 'retrieves the same rate when time hasn\'t expired' do 
        spy = ExchangeSpy.new 
        Arbolito.exchange = spy

        Arbolito.current_rate('USD' => 'ARS')
        Arbolito.current_rate('USD' => 'ARS')

        expect(spy.times_called).to eq(1)
      end

      it 'fetches a new rate when time expired' do 
        spy = ExchangeSpy.new 
        Arbolito.exchange = spy

        Arbolito.current_rate('USD' => 'ARS')
        sleep(6)
        
        Arbolito.current_rate('USD' => 'ARS')

        expect(spy.times_called).to eq(2)
      end
    end
  end
end

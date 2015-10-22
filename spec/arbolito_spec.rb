require 'spec_helper'

describe Arbolito do
  it 'has a version number' do
    expect(Arbolito::VERSION).not_to be nil
  end

  it 'lets you add fixed currency quotes' do
    Arbolito.add_currency_rate(BigDecimal.new(15), 'USD' => 'ARS')
    
    expect(Arbolito.current_rate('USD' => 'ARS')).to eq(BigDecimal.new(15))
  end

  it 'gives you the backward currency rate' do 
    Arbolito.add_currency_rate(BigDecimal.new(15), 'USD' => 'ARS')
    
    expect(Arbolito.current_rate('ARS' => 'USD')).to eq(BigDecimal.new(1) / BigDecimal.new(15))
  end
end

require 'spec_helper'

describe Arbolito do
  it 'has a version number' do
    expect(Arbolito::VERSION).not_to be nil
  end

  before do 
    Arbolito.add_currency_rate(BigDecimal.new(15), 'USD' => 'ARS')
  end

  it 'lets you add fixed currency quotes' do
    expect(Arbolito.current_rate('USD' => 'ARS')).to eq(BigDecimal.new(15))
  end

  it 'gives you the backward currency rate' do 
    expect(Arbolito.current_rate('ARS' => 'USD')).to eq(BigDecimal.new(1) / BigDecimal.new(15))
  end

  it 'can exchange the money with the current currency rate' do
    expect(Arbolito.exchange(BigDecimal.new(100), 'USD' => 'ARS')).to eq(BigDecimal.new(1500))
  end

  it 'can exchange the money backwards with the current currency rate' do
    expect(Arbolito.exchange(BigDecimal.new(1500), 'ARS' => 'USD')).to eq(BigDecimal.new(1500) * (BigDecimal.new(1) / BigDecimal.new(15)))
  end
end

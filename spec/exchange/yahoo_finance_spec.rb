require 'spec_helper' 

describe Arbolito::Exchange::YahooFinance do 
  subject(:exchange) { Arbolito::Exchange::YahooFinance }
  let(:quote) { Arbolito::Currency::Quote.new('USD' => 'UYU') }

  # DEPRECATED Yahoo doesn't support anymore Yahoo Finance so use Alpha Vantage instead
  it 'gives you the current rate of the desired currency conversion' do 
    rate = exchange.find_current_rate(quote)

    expect(rate).to be_a(Arbolito::Currency::Rate)
    
    expect(rate.quote).to eq(quote)
    expect(rate.price).to eq(0.0)
    expect(rate.rated_at).to be_between(Time.now - 60, Time.now)
  end
end
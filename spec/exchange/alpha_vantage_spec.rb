require 'spec_helper' 

describe Arbolito::Exchange::AlphaVantage do 
  let(:api_key) { ENV['ALPHA_VANTAGE_API_KEY'] }
  subject(:exchange) { Arbolito::Exchange::AlphaVantage.new(api_key) }
  let(:quote) { Arbolito::Currency::Quote.new('USD' => 'UYU') }

  it 'gives you the current rate of the desired currency conversion' do 
    rate = exchange.find_current_rate(quote)

    expect(rate).to be_a(Arbolito::Currency::Rate)
    
    expect(rate.quote).to eq(quote)
    expect(rate.price).to be > 0
    expect(rate.rated_at).to be_between(Time.now - 60, Time.now)
  end
end
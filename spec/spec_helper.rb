$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'arbolito'
require 'pry'

RSpec.configure do |config|
  config.after(:each) do
    Arbolito::Store::Memory.clear
  end
end

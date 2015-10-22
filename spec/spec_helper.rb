$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'arbolito'
require 'pry'

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f }

RSpec.configure do |config|
  config.after(:each) do
    Arbolito::Store::Memory.clear
  end
end

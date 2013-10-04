require 'test_helper'

class GmoneyClientTest < ActiveSupport::TestCase
  
  it 'uses .env.test properly' do
    GmoneyClient.url.must_equal 'TEST'
  end


end

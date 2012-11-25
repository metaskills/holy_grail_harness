require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  
  tests ApplicationController

  before { get :index }

  describe '#index' do

    it 'renders' do
      assert_select 'body', text: ''
    end

  end


end

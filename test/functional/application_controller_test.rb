require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  
  before { get :index }

  describe '#index' do

    it 'renders' do
      assert_select 'body', text: ''
    end

  end


end

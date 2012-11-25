require 'test_helper_integration'

class ApplicationTest < ActionDispatch::IntegrationTest
  
  before { visit root_path }

  describe 'index' do

    let(:h1) { find 'h1' }

    it 'renders' do
      h1.must_be :present?
    end

  end


end

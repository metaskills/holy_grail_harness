ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  
  let(:h1_text_loaded)  { 'Test Header' }
  let(:h1_text_clicked) { 'Clicked!' }


end

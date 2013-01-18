HolyGrailHarness::Application.routes.draw do
  
  get "foo/index"

  root :to => 'application#index'

  
end

class ApplicationController < ActionController::Base

  protect_from_forgery

  def index ; render text: "", layout: true ; end


end

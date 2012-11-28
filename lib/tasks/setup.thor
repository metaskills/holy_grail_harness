require 'rails/generators'
require 'active_support/core_ext/string/inflections'

class Setup < Thor::Group

  include Thor::Actions

  argument :my_app_name, type: 'string', required: true, desc: 'The name of your new application.'
  desc "Setup your Rails application using the given 'my_app_name'."

  def create_new_secret_token
    say "Creating new secret token..."
    in_root do
      @secret_token = run("#{extify(:rake)} secret", verbose: false, capture: true).strip
      gsub_file 'config/initializers/secret_token.rb', replace_flag, @secret_token, verbose: false
    end
  end


  protected

  def app
    @app ||= Rails::Generators::Base.new
  end

  def extify(name)
    app.send :extify, name
  end

  def replace_flag
    "<REPLACEME>"
  end

end


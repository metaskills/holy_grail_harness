require 'rails/generators'
require 'active_support/core_ext/string/inflections'

class Setup < Thor::Group

  include Thor::Actions

  argument :my_app_name, type: 'string', required: true, desc: 'The name of your new application.'
  desc "Setup your Rails application using the given 'my_app_name'."


  def init_holy_grail_harness_setup
    
  end

  def clean_prototype_application
    in_root do
      # run 'rm -rf .git'
      run 'rm -rf README.md'
      create_file "README.md", "# #{my_app_name.camelize}"
    end
  end

  def create_new_secret_token
    in_root do
      @secret_token = run("#{extify(:rake)} secret", capture: true).strip
      gsub_file 'config/initializers/secret_token.rb', replace_flag, @secret_token
    end
  end


  protected

  def app
    @app ||= Rails::Generators::Base.new
  end

  def log(*args)
    app.send *args.unshift(:log)
  end

  def extify(name)
    app.send :extify, name
  end

  def replace_flag
    "<REPLACEME>"
  end

end


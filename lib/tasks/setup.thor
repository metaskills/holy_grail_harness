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
      # remove_dir '.git'
      remove_file 'app/assets/images/holy_grail_harness.png'
      remove_file 'app/assets/images/holy_grail_harness.pxm'
      remove_file 'README.md'
      create_file "README.md", "# #{new_app_name_ruby}"
    end
  end

  def search_and_replace_new_app_name
    in_root do
      Dir["**/*"].each do |filepath|
        if File.file?(filepath) && File.expand_path(filepath) != __FILE__
          data = File.read(filepath)
          gsub_file filepath, 'HolyGrailHarness', new_app_name_ruby if data.include? 'HolyGrailHarness'
          gsub_file filepath, 'holy_grail_harness', new_app_name_file if data.include? 'holy_grail_harness'
        end
        if filepath.match /\/holy_grail_harness(\z|\.\w+\z)/
          newpath = filepath.tr 'holy_grail_harness', new_app_name_file
          FileUtils.mv filepath, newpath
        end
      end
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

  def new_app_name_file
    my_app_name.underscore
  end

  def new_app_name_ruby
    my_app_name.camelize
  end

  def extify(name)
    app.send :extify, name
  end

  def replace_flag
    "<HGH_REPLACEME>"
  end

end


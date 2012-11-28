require 'rails/generators'
require 'active_support/core_ext/string/inflections'

class Setup < Thor::Group

  include Thor::Actions

  argument :my_app_name, type: 'string', required: true, desc: 'The name of your new application.'
  desc "Setup your Rails application using the given 'my_app_name'."

  def clean_prototype_application
    in_root do
      remove_dir  '.git'
      remove_file '.gitmodules'
      remove_file 'app/assets/images/holy_grail_harness.png'
      remove_file 'app/assets/images/holy_grail_harness.pxm'
      remove_file 'README.md'
      create_file 'README.md', "# #{new_app_name_ruby}"
      remove_dir  'vendor/assets/javascripts/spine'
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
          newpath = filepath.gsub 'holy_grail_harness', new_app_name_file
          log :move, filepath
          FileUtils.mv filepath, newpath
        end
      end
    end
  end

  def create_new_secret_token
    in_root do
      @secret_token = run("#{extify(:rake)} secret", capture: true).strip
      gsub_file 'config/initializers/secret_token.rb', '012345678901234567890123456789', @secret_token
    end
  end

  def set_or_forget_about_spinejs
    in_root do
      if spinejs?
        remove_file "app/assets/javascripts/#{new_app_name_file}/views/index.js.coffee"
        create_file "app/assets/javascripts/#{new_app_name_file}/views/index.js.coffee", %|
class window.#{new_app_name_ruby}.App.Views.Index extends View  
  @content: ->
    @h1 '#{new_app_name_ruby}'
|.strip
      else
        remove_file "app/assets/javascripts/#{new_app_name_file}/lib/notifications.js.coffee"
        remove_file "app/assets/javascripts/#{new_app_name_file}/views/index.js.coffee"
        remove_file "app/assets/javascripts/#{new_app_name_file}/index.js.coffee"
        create_file "app/assets/javascripts/#{new_app_name_file}/index.js.coffee", %|
#= require_tree ./views
#= require_tree ./models
#= require_tree ./controllers
#= require_self
|.strip
        gsub_file "app/assets/javascripts/application.js", /\A(.*)#{new_app_name_ruby}\.Notifications\.appReady callback/, '\1callback()', verbose: false
        gsub_file "app/views/layouts/application.html.erb", /\A(.*)#{new_app_name_ruby}\.App\.Index\.init.*\Z/, '', verbose: false
        gsub_file "spec/javascripts/spec_helper/fixtures.js.coffee", /\A(.*)#{new_app_name_ruby}\.Notifications\.appReady callback/, '\1callback()', verbose: false
        gsub_file "spec/javascripts/spec_helper/fixtures.js.coffee", /\A.*#{new_app_name_ruby}\.App\.Index\.init\(\).*\Z/, '', verbose: false
        gsub_file "spec/javascripts/spec_helper/helpers.js.coffee", /\A.*Spine.*\Z/, '', verbose: false
        gsub_file "spec/javascripts/app_spec.js.coffee", /\A.*renders|@body.*\Z/, '', verbose: false
      end
    end
  end

  def new_git_repo
    in_root do 
      git :init
      git :add => '.'
      git :commit => "-a -m 'Initial Rails application.'"
    end
  end

  def post_new_git_repo
    in_root do
      if spinejs?
        git "submodule add git://github.com/maccman/spine.git vendor/assets/javascripts/spine"
        git :commit => "-a -m 'Vendor Spine JavaScript framework.'"
      end
    end
  end


  protected

  def new_app_name_file
    my_app_name.underscore
  end

  def new_app_name_ruby
    my_app_name.camelize
  end

  def spinejs?
    return @spinejs if defined? @spinejs
    @spinejs = yes? 'Do you want to use the Spine JavaScript framework?'
  end

  def app
    @app ||= Rails::Generators::Base.new
  end

  def log(*args)
    app.send *args.unshift(:log)
  end

  def extify(name)
    app.send :extify, name
  end

  def git(commands={})
    app.git commands
  end


end


require 'rails/generators'

class Setup < Thor::Group

  # include Thor::Actions
  # include Rails::Generators::Actions
  # Rails::Generators::Base

  desc 'Setup your Rails application with your new name.'
  def foo(my_app_name)
    puts my_app_name.inspect
  end

end


# in_root { run_ruby_script("script/rails generate #{what} #{argument}", :verbose => false) }
# rake "db:migrate"
# inject_into_file 'config/routes.rb', "\n  #{routing_code}\n", { :after => /\.routes\.draw do(?:\s*\|map\|)?\s*$/, :verbose => false }
# append_file "Gemfile", str, :verbose => false
# prepend_file "Gemfile", "source #{source.inspect}\n", :verbose => false
# create_file("vendor/#{filename}", data, :verbose => false, &block)

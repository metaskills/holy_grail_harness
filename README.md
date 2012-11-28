
<img src="https://raw.github.com/metaskills/holy_grail_harness/master/app/assets/images/holy_grail_harness.png" height="204" width="120" style="float:left; margin-right:15px;"/>

# HolyGrailHarness

A bootstrapped Rails application prototype that focuses on simple test patterns for Ruby & JavaScript!

Unlike normal [Rails Application Templates](http://guides.rubyonrails.org/rails_application_templates.html) or more modern Rails application generators like [Rails Composer](http://railsapps.github.com/rails-composer/), the HolyGrailHarness is a basic Rails application that can be considered a prototype and customized via a simple setup script. It is also somewhat opinionated in that it pushes what I believe are the most simple and powerful testing choices. It focus on using Ruby 1.9 or 2.0, MiniTest::Spec, Capybara, Poltergeist, and Konacha. More details on each component and what HolyGrailHarness provides are below.

The HolyGrailHarness is perfect for any of the following 

* Bootstrapping your next Rails application.
* Learning and promoting MiniTest::Spec
* Modern JavaScript testing setups.
* Teaching Rails and/or JavaScript at your next meetup.


# Usage

Super simple. Just follow these steps below. Make sure to replace `my_app_name` below with the name of your new Rails application. The setup script has a few options and the end result will be a new Rails application all ready to go.

  1. [Download](https://github.com/metaskills/holy_grail_harness/archive/master.zip) the project.
  2. Now from the root of "holy_grail_harness" directory.
    * `$ bundle install`
    * `$ bundle exec thor setup my_app_name`

**Why not a normal Rails application template?** I am very persnickety about how I like to organize my code and application directories. Although, Rails application templates provide a really nice feature set. It was much easier for me to bootstrap a new Rails application using this prototype method. The end result is a cleaner Gemfile and application setup that can be vetted and tested from within HolyGrailHarness itself.


# Setup Script Notes

* Things you may want to do manually...
  * Remove root route (root :to => 'application#index')
  * Remove index action (def index ; render text: "", layout: true ; end)
* Test
  - Intergration - Remove or clear out.
* Remove thor/setup script files. Self implode.
* Rename parent directory.
* Display some final message
  - Detect if they have PhantomJS bin in PATH or not.

 
# Testing

* Latest Rails 3.x and jQuery 1.8
* MiniTest::Spec for units and functionals.
  - https://github.com/metaskills/minitest-spec-rails
* MiniTest::Spec with Capybara DSL for integrations.
  - A test_helper_integration.
  - http://techiferous.com/2010/04/using-capybara-in-rails-3/
  - Sets page size to 13" MacBook Air
  - A `save_and_open_page` helper aliased to `page!` to help debug.
  - An ActiveRecord patch to ensure a single connection. No race conditions for a 
    threaded Capybara driver. This is what Cucumber does.
* PhantomJS.
  - http://phantomjs.org
* JavaScript testing with Konacha v2 using Capybara/Poltergeist "PhantomJS" as the driver.
  - https://github.com/jfirebaugh/konacha
  - Proper spec helper setup with sub directories.
    * Talk about spec_helper directory with fixtures and helpers and your own...
  - Proper MVC subdir structures. Include your own, like "lib" and "helpers" for other focused tests.
  - Includes Sinon.JS v1.5.0 http://sinonjs.org
  - Includes jQuery Mockjax v1.5.1 https://github.com/appendto/jquery-mockjax
  - Includes Chai jQuery https://github.com/chaijs/chai-jquery
  - Includes jsDump http://github.com/NV/jsDump
    - Used by internal `myLog()` helpers.
  - New rake task to run all Rails units, functionals, integrations, then konacha specs.
    $ rake test:all
* Sass, silent classes, structure.
  - https://speakerdeck.com/anotheruiguy/sass-32-silent-classes
  - Setup 
* Quite asset logging.
  - Use Thin in development group for those that like using `rails console`
  - Added the QuietAssets gem too. https://github.com/evrone/quiet_assets
* Use the QuietAssets gem for less noisy pipeline logging - https://github.com/evrone/quiet_assets 
* Spine.js - MVC Framework - http://spinejs.com
  - Is vendored into vendor/assets/javascripts/spine at v1.0.8 with a SHA of 457c763d. Allows the use of the coffee src files.
    http://metaskills.net/2012/01/15/rails-and-spine-js-using-the-coffeescript-source/
  - Project requires all of Spine. Includes manager (stacks), ajax, route, and relation. Remove any of these as you see fit.
  - SpacePen View Framework - https://github.com/nathansobo/space-pen
  - An PubSub notification system.
* Dont like X
  - Spine.JS


* Font Awesome http://fortawesome.github.com/Font-Awesome/
* bootstrap


# Extras

* YAML fixtures suck, but facories dont!
  NamedSeeds - Short intro https://github.com/metaskills/named_seeds
  FactoryGirl - https://github.com/thoughtbot/factory_girl
  Removed test/fixtures
  Created test/factories
  FactoryGirl.define do
    factory :user do
      # ...    
    end
  end


# Guard

Both [guard-minitest](https://github.com/guard/guard-minitest) and [guard-konacha](https://github.com/alexgb/guard-konacha) are bundled and ready to go. A basic `Guardfile` is already setup too. Unlike most, this one is split into two groups `:ruby` or `:js`. This lets you focus on either everything or a specific language for your tests.

```
$ guard             # Monitor both Ruby and JavaScript tests.
$ guard -g ruby     # Monitor Ruby tests.
$ guard -g js       # Monitor JavaScript tests.
```

The Guardfile assumes you are running OS X and wish to use the Ruby GNTP (Growl Notification Transport Protocol). If this is not the case, consult the Guard documentation on different [system notification](https://github.com/guard/guard#system-notifications) alternatives.



<!--

* Example of a mock for initial request using fixtures data/responses in the `mockInitialRequest()` spec helper would look something like this for Spine.

```coffeescript
@mockInitialRequest = (callback) =>
  bob = HolyGrailHarness.Test.Seeds.users.bob
  Spine.Model.records  = {}
  Spine.Model.crecords = {}
  helperClearRequests()
  $.mockjax url: "/users/#{bob.id}", responseText: HolyGrailHarness.Test.Response.bobInitial.responseText
  HolyGrailHarness.App.Models.User.fetch id: bob.id
  HolyGrailHarness.App.Models.User.one 'refresh', callback
```

->>

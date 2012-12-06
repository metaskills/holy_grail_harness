
<img src="https://raw.github.com/metaskills/holy_grail_harness/master/app/assets/images/holy_grail_harness.png" height="204" width="120" style="float:left; margin-right:15px;"/>

# HolyGrailHarness

A curated Rails application prototype that focuses on simple test patterns for Ruby & JavaScript!

Unlike normal [Rails Application Templates](http://guides.rubyonrails.org/rails_application_templates.html) or more modern Rails application generators like [Rails Composer](http://railsapps.github.com/rails-composer/), the HolyGrailHarness is a basic Rails application that can be considered a prototype and customized via a simple setup script. It is also somewhat opinionated in that it pushes what I believe are the most simple and powerful testing choices. It focus on using Ruby 1.9 and up, MiniTest::Spec, Capybara, Poltergeist/PhantomJS, and Konacha. More details on each component and what HolyGrailHarness provides are below.

The HolyGrailHarness is perfect for any of the following:

  * Bootstrapping your next Rails application.
  * Learning and promoting MiniTest::Spec
  * Modern JavaScript testing setups.
  * Teaching Rails and/or JavaScript at your next meetup.


# Usage

  * [Download](https://github.com/metaskills/holy_grail_harness/archive/master.zip) the project.
  * Now from the root of "holy_grail_harness" directory.

```shell
$ bundle install
$ bundle exec thor setup my_app_name
```

Make sure to replace `my_app_name` above with the name of your new Rails application. The setup script has a few options, but the end result will be a new Rails application all ready to go. **So why not a normal Rails application template?** I am very persnickety about how I like to organize my code and application directories. Although, Rails application templates provide a really nice feature set. It was much easier for me to bootstrap a new Rails application using this prototype method. The end result is a cleaner Gemfile and application setup that can be vetted and tested from within HolyGrailHarness itself.


# Rails 3

This application prototype will focus on the latest Rails version. At this time, the bundle is locked down to v3.2.9. As Rails updates and is compatible with each component, so will this prototype application be updated. The bundle includes:

  * [QuietAssets](https://github.com/evrone/quiet_assets) gem for silent pipeline logging.
  * [Thin](https://github.com/macournoyer/thin/) webserver. Primarily to be automatically used by Konacha but also good for development if you are not using something like [Pow](http://pow.cx).


# Testing

### MiniTest::Spec All The Way Across The Sky!

Don't wait for Rails 4 to use MiniTest::Spec! This application is using the [minitest-spec-rails](https://github.com/metaskills/minitest-spec-rails) gem which forces `ActiveSupport::TestCase` to subclass `MiniTesst::Spec`. This means that you can start using the MiniTest's Spec or Unit structure and assertions directly within the familiar Rails unit, functional, or integration directories. For full details, check out the [minitest-spec-rails](https://github.com/metaskills/minitest-spec-rails) documentation or some of the [test shims](https://github.com/metaskills/holy_grail_harness/blob/master/test/functional/application_controller_test.rb) within HolyGrailHarness. For example, a `test/unit/user_test.rb` might look like this.

```ruby
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  let(:bob)   { users(:bob) }
  let(:admin) { users(:admin) }

  it 'must respond true to #admin? for administrators only' do
    admin.must_be :admin?
    bob.wont_be   :admin?
  end

end
```

### Capybara Integration Tests With Poltergeist Using PhantomJS

You don't need Cucumber to write good integration tests. Instead use the basic [Capybara DSL](https://github.com/jnicklas/capybara#the-dsl) directly within a Rails integration tests with the most bad ass driver available, [Poltergeist](https://github.com/jonleighton/poltergeist), which is built on top of [PhantomJS](http://phantomjs.org). Never again worry about installing Qt so you can compile capybara-webkit, just go download a [pre-compiled PhantomJS binary](http://phantomjs.org/download.html) for your specific platform and enjoy 20% faster integration test runs vs capybara-webkit.

Integration tests are still within the `ActionDispatch::IntegrationTest` class and as promised, MiniTest::Spec is available here too. Each test file needs to require the [test_helper_integration](https://github.com/metaskills/holy_grail_harness/blob/master/test/test_helper_integration.rb) which provides the following base features.

  * Sets page size to that of a 13" MacBook Air.
  * Resets Capybara sessions after each test.
  * Provides a `#save_and_open_page` or `#page!` screen shot method.
  * Ensures a single ActiveRecord DB connection for transactional test runs.
  * An `#execjs` helper for bridging Ruby and the JavaScript under test.

HolyGrailHarness comes with a integration test example in the [test/integration/application_test.rb](https://github.com/metaskills/holy_grail_harness/blob/master/test/integration/application_test.rb) file. An integration test might look something like this.

```ruby
require 'test_helper_integration'

class ApplicationTest < ActionDispatch::IntegrationTest
  
  before { visit root_path }

  let(:h1) { find 'h1' }

  it 'renders' do
    h1.must_be :present?
  end

end
```

### Konacha JavaScript Tests Using PhantomJS

Move over Jasmine(rice), [Konacha](https://github.com/jfirebaugh/konacha) is the way to test your JavaScript now. Konacha is a Rails engine that allows you to test your JavaScript with the [Mocha](http://visionmedia.github.com/mocha/) test framework and [Chai](http://chaijs.com) assertion library. Konacha's killer feature is a sandboxed `<iframe>` for each test spec to run within as well as full Rails asset pipeline integration. The HolyGrailHarness does all the work to get your Konacha `spec/javascripts` directory all setup and ready to go. Highlights include:

  * An [initializer](https://github.com/metaskills/holy_grail_harness/blob/master/config/initializers/konacha.rb) that sets up Poltergeist as the Capybara driver.
  * A directory structure for model, view, and controller specs.
  * A [`spec_helper.js.coffee`](https://github.com/metaskills/holy_grail_harness/blob/master/spec/javascripts/spec_helper.js.coffee) for your specs to require. Provides global setup, configurations and vendor requires.

HolyGrailHarness also has a [`spec/javascripts/spec_helper`](https://github.com/metaskills/holy_grail_harness/tree/master/spec/javascripts/spec_helper) directory meant for helpers and extensions that should be available to all specs. We have included a [`fixtures.js.coffee`](https://github.com/metaskills/holy_grail_harness/blob/master/spec/javascripts/spec_helper/fixtures.js.coffee) file that demonstrates how to setup JSON data fixtures for use from anything to stubbing requests to instantiating new model objects. We also have a [`helpers.js.coffee`](https://github.com/metaskills/holy_grail_harness/blob/master/spec/javascripts/spec_helper/helpers.js.coffee) file that exposes a few top level functions that make debugging your JavaScript easy. Below are the vendored JavaScript libraries that are required by the `spec_helper`.

  * [Sinon.JS](http://sinonjs.org) - For spies, stubs, faking time, etc.
  * [jQuery Mockjax](https://github.com/appendto/jquery-mockjax) - Best way to mock jQuery's AJAX functions.
  * [Chai jQuery](https://github.com/chaijs/chai-jquery) - Chai assertions for jQuery.
  * [jsDump](http://github.com/NV/jsDump) - Used by the `myLog()` helper.

Because your CI system should run all your tests, the HolyGrailHarness has added a Rake task to the test namespace that runs the default rails test task (units, functional, integrations) then your Konacha tests.

```shell
$ rake test:all     # Runs all Rails tests, then Konacha tests.
```

### Guard

TDD in style and run your tests when you hit save! Both [guard-minitest](https://github.com/guard/guard-minitest) and [guard-konacha](https://github.com/alexgb/guard-konacha) are bundled and ready to go. A basic `Guardfile` is already setup too. Unlike most, this one is split into two groups `:ruby` or `:js`. This lets you focus on either everything or a specific language for your tests.

```shell
$ guard             # Monitor both Ruby and JavaScript tests.
$ guard -g ruby     # Monitor Ruby tests.
$ guard -g js       # Monitor JavaScript tests.
```

The Guardfile assumes you are running OS X and wish to use the Ruby GNTP (Growl Notification Transport Protocol). If this is not the case, consult the Guard documentation on different [system notification](https://github.com/guard/guard#system-notifications) alternatives.

### Factories And Fixtures

ActiveRecord YAML fixtures suck, but so do slow tests that rely on an empty database with excessive setups based on factories. The answer? Take advantage of the best each has to offer. Use factories to populate fixtures into the test database while leveraging database transactions during your test runs. The end result is a known factory story with the ability to create more test data as needed using the same factories. Allowing factories to properly hook into model logic means no more decomposing business logic into YAML text files. How?

The HolyGrailHarness bundles the [named_seeds](https://github.com/metaskills/named_seeds) gem along with the [factory_girl](https://github.com/thoughtbot/factory_girl) gem. The NamedSeeds library checks for the existence of a [`db/test/seeds.rb`](https://github.com/metaskills/holy_grail_harness/blob/master/db/test/seeds.rb) file and if present, loads that file. Just like Rails' own `db/seeds.rb` anything in this file goes. The only difference is that this seed file is populated right before you tests are run so they persist between transactions. You also get the benefit of using this same seed data in development as part of the normal Rails `db:setup` process. Read the [full documentationn](https://github.com/metaskills/named_seeds#namedseeds) on their site on how to use it. Below is a brief example.

Create factories in the `test/factories` directory. Note, factories are best when they make `valid garbage™`, so the HolyGrailHarness also requires the [forgery](https://github.com/sevenwire/forgery) gem to help with that.

```ruby
# In test/factories/user_factory.rb

FactoryGirl.define do
  
  factory :user do
    email      { Forgery::Email.address }
    first_name { Forgery::Name.first_name }
    last_name  { Forgery::Name.first_name }
    password   'test'  
  end
  
end
```

When making seed data, be explicit with your attributes that may be forged in the factory, database seeds should be consistent and have meaningful attributes. In this example we are creating an admin user. Note too how we are using `NamedSeeds.identify` which mimics AcctiveRecord's fixture identity. This gives us a handle to the fixture within our tests. We also create the `@admin` instance variable because we might want to use that user later on in the fixture story.

```ruby
# In db/test/seeds.rb

require 'factory_girl'
FactoryGirl.find_definitions rescue true
include FactoryGirl::Syntax::Methods

@admin = create :user, id: NamedSeeds.identify(:admin), 
                       first_name: 'Admin', last_name: 'User', email: 'admin@test.com'
```

 Lastly, in your [`test/test_helper.rb`](https://github.com/metaskills/holy_grail_harness/blob/master/test/test_helper.rb) file, declare that you have a named seed to the users model. This will allow all your test to act just like ActiveRecord fixtures and use the `users(:admin)` helper to get to that seeded fixture.

```ruby
# In test/test_helper.rb

class ActiveSupport::TestCase
  
  named_seeds :users

end
```


# MVC JavaScript

The HolyGrailHarness wants you to use some type MV* structure for your JavaScript. The setup script supports [Spine.js](http://spinejs.com) as an option, however you can decline and all traces of Spine.js will be removed. If so, the following features will still remain. 

A single JavaScript [namespace](https://github.com/metaskills/holy_grail_harness/blob/master/app/assets/javascripts/holy_grail_harness/lib/namespaces.js.coffee) on the window object. This namespace creates a model, view, controller object structure that direly matches to the [`app/assets/javascripts/#{my_app_name}/(model|view|controller)`](https://github.com/metaskills/holy_grail_harness/tree/master/app/assets/javascripts/holy_grail_harness) directory structure within the Rails asset pipeline. This JavaScript namespace and matching directories will be changed to your new application name as part of the setup task. Here is an example of a User model whose corresponding file would be found in the `app/assets/javascripts/my_app_name/models/user.js.coffee` file.

```coffeescript
class @MyAppName.App.Models.User extends View  
  @configure 'User', 'id', 'email'
```

The main [`application.js`](https://github.com/metaskills/holy_grail_harness/blob/master/app/assets/javascripts/application.js) file requires all vendor frameworks, then the [`index.js.coffee`](https://github.com/metaskills/holy_grail_harness/blob/master/app/assets/javascripts/holy_grail_harness/index.js.coffee) of within your application name directory. Use this file to boot your JavaScript application and/or setup your root view controller.

Also included is the [SpacePen](https://github.com/nathansobo/space-pen) view framework. SpacePen is a powerful and minimalist client-side view framework authored in CoffeeScript. It is actually a jQuery subclass which makes your views really easy to traverse and respond to controller events. Read my [*View Controller Patterns With Spine.js & SpacePen*](http://metaskills.net/2012/05/22/view-controller-patterns-with-spine-js-and-spacepen/) article to learn why views should not be dumb and how you can take advantage of SpacePen no matter what JavaScript MV* framework you use.

### With Spine.js

If you choose to use Spine.js as your JavaScript MVC structure, the setup script will create a git submodule to the Spine repository to the `vendor/assets/javascripts/spine` directory. This allows your project to use the the source CoffeeScript files, which makes for a wonderful [learning experience](http://metaskills.net/2012/01/15/rails-and-spine-js-using-the-coffeescript-source/) to both Spine.js and idomatic CoffeeScript. 

By default the [`index.js.coffee`](https://github.com/metaskills/holy_grail_harness/blob/master/app/assets/javascripts/holy_grail_harness/index.js.coffee) will require all Spine components. This includes manager (stacks), ajax, route, and relation. Remove anything that you do not need. This file also defines the root view controller along with a `MyAppName.App.Index.init()` class level initialization function. This is called in the main [`application.html.erb`](https://github.com/metaskills/holy_grail_harness/blob/master/app/views/layouts/application.html.erb) layout file for you too. Likewise, the application init is done in the Mocha before filters mentioned above in both the [`spec_helper.js.coffee`](https://github.com/metaskills/holy_grail_harness/blob/master/spec/javascripts/spec_helper.js.coffee) and [`fixtures.js.coffee`](https://github.com/metaskills/holy_grail_harness/blob/master/spec/javascripts/spec_helper/fixtures.js.coffee) files. If you examine these files closely, you will see how they make use of Mocha's `done()` callback so that you can cleanly abstract AJAX mocks and anything else related to your JavaScript application's boot process. Here is an example of how you might setup your `initApplication()`.

```coffeescript
@initApplication = (callback) =>
  bob = MyAppName.Test.Seeds.users.bob
  $.mockjax url: "/users/#{bob.id}", responseText: HolyGrailHarness.Test.Response.bobInitial.responseText
  MyAppName.App.Models.User.fetch id: bob.id
  MyAppName.App.Models.User.one 'refresh', callback
```

No JavaScript project should be without a local notification system to help keep disparate components up to date. Thankfully, Spine's event module makes a local PubSub system a breeze. The HolyGrailHarness has a [`notifications.js.coffee`](https://github.com/metaskills/holy_grail_harness/blob/master/app/assets/javascripts/holy_grail_harness/lib/notifications.js.coffee) that exposes a class level `bind()` and `trigger()` to any event string/namespace you want. To make more simple, we recommend creating class level functions that expose the event name as the function name and pass the args to the `handle()` function. We have done this for the `MyAppName.Notifications.appReady()` to demonstrate. Calling this function will trigger the `app.ready` event and passing a function to this function will bind that function to the same event name.


# Sass & Compass

[Sass](http://sass-lang.com) is the only way to write CSS for today's modern web applications. [Compass](http://compass-style.org) is the CSS framework that no Sass user should go without. Together they provide a foundation for writing beautiful CSS using pre-built time saving functions. The HolyGrailHarness includes both the [sass-rails](https://github.com/rails/sass-rails) and [compass-rails](https://github.com/Compass/compass-rails) gems.

To get you started on the right path, we have also created a basic structure within the `app/assets/stylesheets` asset pipeline directory to help you organize your Sass files. Here is the directory structure below.

```
├── application.css
├── application
│   ├── _layout.scss
│   ├── index.scss
│   ├── components
│   │   └── _foo.scss
└── shared
    ├── _animations.scss
    ├── _fonts.scss
    ├── _mixins.scss
    ├── _placeholders.scss
    ├── _variables.scss
    └── base.scss
```

### The application.css file.

Never write CSS in `application.css`. Say what? I know right, but trust me. Just consider this file a top level bundle dependency that only requires other top level bundle assets. Here is the contents of that file. Notice how it requires a bundle called twitter and an index. One is for twitter bootstrap, see section below, and the other is the index to your own Sass framework.

```css
/*
 *= require application/twitter
 *= require application/index
*/
```

### The shared directory.

Think of this as your own Compass framework. The [`base.scss`](https://github.com/metaskills/holy_grail_harness/blob/master/app/assets/stylesheets/shared/base.scss) is your single file to `@import` to get everything loaded and ready to go. **Nothing in any of the shared files should generate CSS!** Importing `shared/base` should act just like importing `compass`. Use these files for setting your own variables and creating misc helper functions & mixins. There is a variables file for... variables! Another for animations, fonts and mixins too.

Pay special attention to the `_placeholders.scss` file. If you do not know about Sass 3.2's placeholder selectors (silent classes) and how they make presentational classes efficiently extended by semantic ones, then I highly suggest you read Dale Sande's presentation titled [Sass 3.2 Silent Classes](https://speakerdeck.com/anotheruiguy/sass-32-silent-classes) on Speaker Deck.

Below is the contents of the `base.scss` file, take note of the order. See too how we import the entire Compass framework too. This means that all of your Sass code in any of the shared files can take full advantage of both Bootstrap and Compass' variables and mixins. Epic win!

```sass
// Think of this file as your own compass. Importing the base, never generates CSS.

@import "shared/variables";
@import "bootstrap/mixins";
@import "compass";
@import "compass/layout";
@import "compass/css3/user-interface";
@import "shared/fonts";
@import "shared/mixins";
@import "shared/animations";
@import "shared/placeholders";
```

### The application directory.

Organize this as you see fit. We have started you off by creating a `_layout.scss` file for your general layout/structure styles. There is also a `components` directory which all sub files are imported via a glob. The idea is that components are not dependent upon another. Files that might go in here are things like datepicker, navigation, and general files named after components or widgets. Below is what the `application/index.scss` looks like.

```sass
@import "shared/base";
@import "./layout";
@import "components/*";
```


# Twitter Bootstrap

[Twitter Bootstrap](http://twitter.github.com/bootstrap/) is awesome, but [LESS is not](http://metaskills.net/2012/02/27/too-less-should-you-be-using-sass/). That is why the HolyGrailHarness uses the [bootstrap-sass](https://github.com/thomas-mcdonald/bootstrap-sass) gem that converts all the Bootstrap LESS files to Sass. Making them ready to import via the Rails asset pipeline.

As shown above in the Sass section, we require the `application/twitter.scss` bundle asset from the top level `application.css` bundle file. This twitter bundle file, contents below, take advantage of your shared variables before importing bootstrap from the gem. In this way you can define variables that tweak bootstrap. A good example would be button colors, column widths, etc. Later on in the file you can extend bootstrap styles to your liking. For instance, add more padding to buttons.

```sass
@import "shared/variables";
@import "bootstrap";
@import "font-awesome";

// Tweak or redefine Twitter classes below.
```

### Font Awesome

The glyph icons included in Twitter Bootstrap are horrible for hi-resolution "retina" displays typically found on mobile devices. Thankfully the [Font Awesome](http://fortawesome.github.com/Font-Awesome/) project provides a drop in replacement that instead uses icon fonts vs raster images. 

The HolyGrailHarness vendors these font files and the needed `font-awesome.scss` file and requires them as part of the Twitter Bootstrap bundle shown above.





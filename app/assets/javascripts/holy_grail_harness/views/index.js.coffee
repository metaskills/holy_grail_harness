class window.HolyGrailHarness.App.Views.Index extends View
  
  @content: ->
    @div class: 'container', style: 'margin-top:40px;', =>
      @div class: 'row', =>
        @div class: 'span2', =>
          @img src: '/assets/holy_grail_harness.png', width: '162', height: '272'
        @div class: 'span10', =>
          @h1 'Holy Grail Harness', style: "font-family:'Helvetica Neue'; font-size:60px; color:rgb(90,90,90); font-weight:200; margin-top:50px;"
          @div class: 'well well-large', =>
            @p =>
              @raw """
                   Thanks for downloading the Holy Grail Harness application template for Rails. To
                   customize this application, please run <code>$ bundle install</code> then run 
                   <code>$ bundle exec thor setup my_app_name</code>. Whatever you choose for "my_app_name" will be 
                   used for your Rails application name.
                   """

#= require spine/src/spine
#= require spine/src/manager
#= require spine/src/ajax
#= require spine/src/route
#= require spine/src/relation
#= require ./lib/namespaces
#= require ./lib/notifications
#= require_tree ./views
#= require_tree ./models
#= require_tree ./controllers
#= require_self

class window.HolyGrailHarness.App.Index extends Spine.Controller

  @init: ->
    HolyGrailHarness.Application or= new this

  constructor: ->
    @view = new HolyGrailHarness.App.Views.Index
    super el: @view
    @render()

  render: ->
    $('body').html @view
    HolyGrailHarness.Notifications.appReady()
    true


###
A single PubSub notification center.
###
class window.HolyGrailHarness.Notifications extends Spine.Module

  @extend Spine.Events

  @appReady: (args) ->
    @handle 'app.ready', args

  # Private
  
  @handle: (id, args) ->
    if typeof args is 'function' then @bind id, args else @trigger id, args


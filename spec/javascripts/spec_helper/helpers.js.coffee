
# Logging

@myLog = (obj) ->
  console.log myLogParser(obj)

@myLogLine = (obj) ->
  myLogParser(obj)

@myLogParser = (obj) ->
  if typeof obj is 'string' then obj else jsDump.parse obj


# Ajax

@helperClearRequests = ->
  $.mockjaxClear()
  Spine.Ajax.clearQueue()

@helperMock200Response = ->
  $.mockjax url: '*', status: 200, responseText: ''

@helperSpineRequestCount = ->
  Spine.Ajax.queue().length

@helperjQueryRequestCount = ->
  jQuery.active


# Misc

@helperDeepClone = (obj) ->
  if not obj? or typeof obj isnt 'object'
    return obj
  newInstance = new obj.constructor()
  for key of obj
    newInstance[key] = helperDeepClone obj[key]
  newInstance

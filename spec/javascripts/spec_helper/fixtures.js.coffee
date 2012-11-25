
# Data Objects

HolyGrailHarness.Test.Seeds =
  users:
    bob: {id: 1, email: 'bob@test.com'}


# Data Responses

HolyGrailHarness.Test.ResponseJSON =
  bobInitial:
    id: HolyGrailHarness.Test.Seeds.users.bob.id
    email: HolyGrailHarness.Test.Seeds.users.bob.email

HolyGrailHarness.Test.Response =
  bobInitial: 
    status: 200
    responseText: JSON.stringify HolyGrailHarness.Test.ResponseJSON.bobInitial


# Data Accessors

@users = (name) ->
  User.find HolyGrailHarness.Test.Seeds.users[name].id


# AJAX Requests

@initApplication = (callback) =>
  HolyGrailHarness.Notifications.appReady callback
  HolyGrailHarness.App.Index.init()

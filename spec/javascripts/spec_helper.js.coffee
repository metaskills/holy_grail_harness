#= require application
#= require sinon-1.5.0
#= require jquery.mockjax-1.5.1
#= require chai-jquery
#= require jsDump
#= require spec_helper/fixtures
#= require spec_helper/helpers

chai.Assertion.includeStack = true

$.mockjaxSettings.log = (msg) -> # Silence noise.
$.mockjaxSettings.contentType = 'application/json'

mocha.suite.beforeAll (done) ->
  initApplication => done()

mocha.suite.beforeEach ->
  HolyGrailHarness.Application.render()
  @body = $('body')

mocha.suite.afterEach ->
  helperClearRequests()



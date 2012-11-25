#= require spec_helper

describe 'HolyGrailHarness.Application', ->
  
  it 'is initialized', ->
    expect(HolyGrailHarness).to.have.property 'Application'

  it 'renders', ->
    expect(@body).to.contain 'Holy Grail Harness'


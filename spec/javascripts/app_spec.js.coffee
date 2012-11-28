#= require spec_helper

describe 'HolyGrailHarness.Application', ->
  
  it 'is defined', ->
    expect(window).to.have.property 'HolyGrailHarness'

  it 'renders', ->
    expect(@body).to.contain 'HolyGrailHarness'



function TestCase__Expectation_MandatoryFields()

  mandatoryFields = [ "mockObj", "methodName", "setMockObj", "create", "once", "twice", "thrice", "exactly", "never", "withArguments", "mockFunction" ]

  mockInstance = Mock( { } )
  expectationInstance = Expectation()

  return m.AssertAAHasKeys( expectationInstance, mandatoryFields )

end function

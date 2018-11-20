
function TestCase__Actions_MandatoryFields()

  mandatoryFields = [ "mockObj", "methodName", "setMockObj", "create", "returns", "mockFunction" ]

  mockInstance = Mock( { } )
  actionsInstance = Actions()

  return m.AssertAAHasKeys( actionsInstance, mandatoryFields )

end function


function TestCase__Mock_MandatoryFields()

  mandatoryFields = [ "objReference", "objCopy", "when", "expects", "verify", "proxy", "restore" ]

  return m.AssertAAHasKeys( m.mockWeightUnitConvertor, mandatoryFields )

end function


function TestCase__Mock_SetReturnValueIsReturned()

  m.mockWeightUnitConvertor.restore()

  m.mockWeightUnitConvertor.when( "lbToKg" ).returns( 10 )
  return m.AssertEqual( 10, m.mockWeightUnitConvertor.proxy().lbToKg( 23 ) )

end function


function TestCase__Mock_TestIfExpectationsMatch()

  m.mockWeightUnitConvertor.restore()

  m.mockWeightUnitConvertor.when( "lbToKg" ).returns( 10 )
  m.mockWeightUnitConvertor.expects( "lbToKg" ).once().withArguments( [ 10.0 ] )

  scale = ScaleService( m.mockWeightUnitConvertor.proxy() )
  scale.Measure( "lb", 10.0 )
  measurement = scale.DisplayMeasurement( "kg" )

  return m.AssertTrue( m.mockWeightUnitConvertor.verify() )

end function


function TestCase__Mock_TestIfCorrectProxyIsReturned()
  return m.AssertAAHasKeys( m.mockWeightUnitConvertor.proxy(), m.unitConvertor.Keys() )
end function


function TestCase__Mock_TestIfStateIsRestoredToDefault()

  m.mockWeightUnitConvertor.restore()
  m.mockWeightUnitConvertor.expects( "lbToKg" ).once().withArguments( [ 10.0 ] )
  m.mockWeightUnitConvertor.restore()

  return m.AssertTrue( m.mockWeightUnitConvertor.verify() )

end function

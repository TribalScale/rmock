
function TestCase_DisplayMeasurement()

  ' Set up
  mockUnitConvertor = Mock( UnitConversionService() )
  mockUnitConvertor.when("lbToKg").returns(1.81437)
  mockUnitConvertor.expects("lbTokg").once().withArguments( [ 4.0 ] )

  ' Exercise
  scale = ScaleService( mockUnitConvertor.proxy() )
  scale.Measure( "lb", 4 )
  measurement = scale.DisplayMeasurement( "kg" )

  ' Verify
  verifiedMock = mockUnitConvertor.verify()
  measurementEquals = ( measurement = "1.81437kg" )

  return m.assertTrue( ( verifiedMock AND measurementEquals ) )

end function

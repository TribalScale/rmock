
' Sample Test Suite
function TestSuite__Mock()

  this = BaseTestSuite()

  this.name = "MockTestSuite"

  ' Set up and Tear down methods'
  this.SetUp = MockTestSuite__SetUp
  this.TearDown = MockTestSuite__TearDown

  ' Adding sample test cases'
  this.addTest("sample isValid check", TestCase__Mock_isValidTestCase)
  this.addTest("Sample scale service returns the correct display measurement", TestCase_DisplayMeasurement )

  ' Mock Library test cases
  this.addTest( "Mock object contains mandatory fields", TestCase__Mock_MandatoryFields )
  this.addTest( "Mock object returns the set value", TestCase__Mock_SetReturnValueIsReturned )
  this.addTest( "Mock object verifies the set expectations correctly", TestCase__Mock_TestIfExpectationsMatch )
  this.addTest( "Mock object returns the correct proxy object", TestCase__Mock_TestIfCorrectProxyIsReturned )
  this.addTest( "Mock object restores it's state correctly", TestCase__Mock_TestIfStateIsRestoredToDefault )

  ' Expectation Object
  this.addTest( "Expectation object contains mandatory fields", TestCase__Expectation_MandatoryFields )

  ' Action Object
  this.addTest( "Actions object contains mandatory fields", TestCase__Actions_MandatoryFields )

  return this
end function

'*********** HELPERS ****************'
function MockTestSuite__SetUp()

  m.unitConvertor = UnitConversionService()
  m.mockWeightUnitConvertor = Mock( m.unitConvertor )

end function

function MockTestSuite__TearDown()

  m.mockWeightUnitConvertor = invalid

end function

'************ TEST CASES ************'

function TestCase__Mock_isValidTestCase()
  dummyStr = ""
  return m.assertTrue( isValid(dummyStr) )
end function

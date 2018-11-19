
' Sample Test Suite
function TestSuite__Sample()

  this = BaseTestSuite()

  this.name = "SampleTestSuite"

  ' Set up and Tear down methods'
  this.SetUp = SampleTestSuite__SetUp
  this.TearDown = SampleTestSuite__TearDown

  ' Adding Test cases'
  this.addTest("isValid() Type Check", TestCase__Sample_isValidTestCase)
  this.addTest("DisplayMeasurement TestCase", TestCase_DisplayMeasurement )

  ' Array utils test cases'
  this.addTest("ArrayMap - Mock Function Test Case", TestCase__ArrayMap )

  return this
end function

'*********** HELPERS ****************'
function SampleTestSuite__SetUp()

end function

function SampleTestSuite__TearDown()
end function

'************ TEST CASES ************'

function TestCase__Sample_isValidTestCase()
  dummyStr = ""
  return m.assertTrue( isValid(dummyStr) )
end function

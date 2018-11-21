# rMock - A mock library for brightscript language.

Standalone mocks for brightscript. It works with Roku's [Unit Test Framework](https://github.com/rokudev/unit-testing-framework/blob/master/docs/unit-test-framework.md) and can work with any brightscript test framework.

## Getting Started

1. Clone or Fork the code from the github repo
2. Deploy code to device
3. This should display a blank page. You'd have to see the test results on your telnet port: <DEVICE_IP>:8085. You can find more information on [debugging here](https://sdkdocs.roku.com/display/sdkdoc/Debugging+Your+Application)

### Using in a code base

To include the rMock library in your actual testsuite, you will need to copy the rMock.brs file found on the `/source` folder. Make sure to include this file within `/source` folder on your project. It can be placed within any subfolder under `/source`

You can find more as to how to use the `Mock` library from the documentation.

### Prerequisites

A text editor to make changes and a roku device to deploy the program onto.

### Deploying to a device

We recommend using Atom as your code editor of choice for the following and using the [Roku Develop](https://atom.io/packages/roku-develop) plugin to make your deployments.

Alternatively, you can follow the [standard deployment procedure](https://sdkdocs.roku.com/display/sdkdoc/Loading+and+Running+Your+Application) as well

### Code Examples

Use the `Mock` method to create a mock object to be used as a dependency on the subject under test.

You can find an example of how the mock object is used below. More detailed docs about the Mock, Expectation and Actions object can be found in the docs section.

```

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
  mockStatus = mockUnitConvertor.verify()
  isEquals = ( measurement = "1.81437kg" )

  return m.assertTrue( ( mockStatus AND isEquals ) )

end function

```


### And coding style tests

Please find the coding and commit formatting styles within [contributing](CONTRIBUTING.md) section

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags).

## Authors

* **Mark Jefferson Arthur** - *Initial work* - [Tribalscale](https://github.com/TribalScale)
* **Mark Zou** - *Initial work* - [Tribalscale](https://github.com/TribalScale)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the Apache License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* The mock framework builds on the work described on the paper [Endo Testing - Unit Testing with Mock Objects](https://www2.ccs.neu.edu/research/demeter/related-work/extreme-programming/MockObjectsFinal.PDF). Everything mentioned in the paper has not been accomplished but the most basic level needed for brightscript has been implemented.
* We looked at several popular mock frameworks out in the market for other languages ( JMock, EasyMock, Jest, Jasmine, Sinon.js...etc )
* A special mention to the article written by [Martin Fowler](https://martinfowler.com/articles/mocksArentStubs.html) and [Uncle Bob](https://blog.cleancoder.com/uncle-bob/2014/05/14/TheLittleMocker.html). Their teaching has served us understand the craft of building software.

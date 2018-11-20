
' Creates a mock object Instance
' @param object. An actual implementation or a suitable stub
' @return object A mock object
function Mock( obj as Dynamic, expctn = Expectation() as Object, actn = Actions() as Object )

  _objCopy = clone( obj )
  _objCopy.append( { _mockDetails: { calls: 0, callCount: 0 }, _expectations: { } } )

  mockObj = {

    objReference: obj,
    objCopy: _objCopy,
    actn: actn,
    expctn: expctn,


    ' Sets up the actions on the mock obj
    ' @param string methodname
    ' @return object action
    when: function( methodName as String )

      m.actn.create( methodName )
      return m.actn

    end function,


    ' Sets up the expectation
    ' @param String methodName
    ' @return Object expection object
    expects: function( methodName as String )

      if ( m.objCopy._expectations.DoesExist( methodName ) ) then return m.objCopy._expectations.Lookup( methodName )

      m.objCopy._expectations[ methodName ] = m.expctn.create( methodName )
      return m.expctn

    end function,


    ' Verifies if the expectations were satisfied
    ' @return Boolean true on success, false otherwise
    verify: function()

      parameterStatus = true

      if ( isArray( m.objCopy._mockDetails["expArgValues"] ) )
        parameterStatus = arrayEquals( m.objCopy._mockDetails["expArgValues"], m.objCopy._mockDetails["argValues"] )
      end if

      callCountStatus = ( m.objCopy._mockDetails.calls = m.objCopy._mockDetails.callCount )

      return ( parameterStatus AND callCountStatus )

    end function,


    ' Returns a mock of the given proxy object
    proxy: function()
      return m.objCopy
    end function,

    ' Restores all mocked functions to be back to the given reference
    restore: function()

      _objCopy = clone( m.objReference )
      _objCopy.append( { _mockDetails: { calls: 0, callCount: 0 }, _expectations: { } } )

      m.objCopy = _objCopy

    end function

  }

  mockObj.actn.setMockObj( mockObj )
  mockObj.expctn.setMockObj( mockObj )

  return mockObj

end function

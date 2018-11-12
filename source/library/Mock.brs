
' Creates a mock object Instance
' @param object. An actual implementation or a suitable stub
' @return object A mock object
function Mock( obj as Dynamic )

  obj.append( { _mockDetails: { calls: 0, callCount: 0 }, _expectations: { } } )
  obj.append( { funcObserv: CreateObject("roSGNode", "node") } )

  mockObj = {


    objReference: obj
    objCopy: obj


    ' Sets up the expectation
    ' @param String methodName
    ' @return Object expection object
    expects: function( methodName as String )

      expctn = Expectation( m )

      if ( m.objCopy._expectations.DoesExist( methodName ) ) then return m.objCopy._expectations.Lookup( methodName )

      m.objCopy._expectations[ methodName ] = expctn.create( methodName )
      return expctn

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
    end function

  }

  return mockObj

end function

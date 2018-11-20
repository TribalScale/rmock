
function Actions()

  obj = {

    mockObj: invalid,
    methodName: ""

    ' set a mockObj reference
    ' @param object mockObj
    setMockObj: function( mockObj as Object )
      m.mockObj = mockObj
    end function,

    ' Creates a mock action item for the given method
    ' @param String methodName
    create: function( methodName = "" as String )

      if ( Len( methodName ) > 0 )
        m.methodName = methodName
        m.mockObj.objCopy[ methodName ] = m.mockFunction
        m.mockObj.objCopy._mockDetails[ methodName ] = { calls: 0, callCount: 0 }
      end if

      return m

    end function,

    ' Sets a return value on the expectation
    ' @param dynamic object type
    returns: function( value as Dynamic )

      m.mockObj.objCopy._mockDetails[ m.methodName ][ "returnValue" ] = value
      m.mockObj.objCopy._mockDetails[ "returnValue" ] = value

      return m

    end function,

    ' mock anonymous function to create our stub
    ' @param: dynamic type (n times)
    mockFunction: function( p1 = invalid as Dynamic, p2 = invalid as Dynamic, p3 = invalid as Dynamic, p4 = invalid as Dynamic, p5 = invalid as Dynamic )

      ' To Do: Store call stats within mockDetails with the methodName

      argValues = []

      if ( isValid( p1 ) ) then argValues.push( p1 )
      if ( isValid( p2 ) ) then argValues.push( p2 )
      if ( isValid( p3 ) ) then argValues.push( p3 )
      if ( isValid( p4 ) ) then argValues.push( p4 )
      if ( isValid( p5 ) ) then argValues.push( p5 )

      m._mockDetails["argValues"] = argValues
      m._mockDetails.calls = m._mockDetails.calls + 1

      if ( isValid( m._mockDetails[ "returnValue" ] ) ) then return m._mockDetails[ "returnValue" ]

    end function

  }

  return obj

end function

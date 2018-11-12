
' Expectation Object Definition
' @param object a mock object instance
' @return object expectation object instance
function Expectation( mockObj as Object )

  obj = {
    mockObj: mockObj,
    methodName: "",

    ' Replaces the given method name with an anonymous function
    ' @param string methodName
    create: function( methodName = "" as String )

      if ( Len( methodName ) > 0 )
        m.methodName = methodName
        m.mockObj.objCopy[ methodName ] = m.mockFunction
        m.mockObj.objCopy._mockDetails[ methodName ] = { calls: 0, callCount: 0 }
      end if

      return m

    end function,

    once: function()

      m.mockObj.objCopy._mockDetails[ m.methodName ][ "callCount" ] = 1
      m.mockObj.objCopy._mockDetails[ "callCount" ] = 1

      return m

    end function,

    twice: function()

      m.mockObj.objCopy._mockDetails[ m.methodName ][ "callCount" ] = 2
      m.mockObj.objCopy._mockDetails[ "callCount" ] = 2

      return m

    end function,

    thrice: function()

      m.mockObj.objCopy._mockDetails[ m.methodName ][ "callCount" ] = 3
      m.mockObj.objCopy._mockDetails[ "callCount" ] = 3

      return m

    end function,

    ' Called exactly to a set number
    ' @param integer number
    exactly: function( number as Integer )

      m.mockObj.objCopy._mockDetails[ m.methodName ][ "callCount" ] = number
      m.mockObj.objCopy._mockDetails[ "callCount" ] = number

      return m

    end function,

    ' Never called
    never: function()

      m.mockObj.objCopy._mockDetails[ m.methodName ][ "callCount" ] = 0
      m.mockObj.objCopy._mockDetails[ "callCount" ] = 0

      return m

    end function,

    ' method call with corresponding argument values
    ' @param array object. Each index in the array corresponds to parameter order in the function signature
    withArguments: function( values = [] as Object )

      m.mockObj.objCopy._mockDetails[ m.methodName ][ "expArgValues" ] = values
      m.mockObj.objCopy._mockDetails[ "expArgValues" ] = values

      return m

    end function

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

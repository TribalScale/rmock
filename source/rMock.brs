
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

' Expectation Object Definition
' @param object a mock object instance
' @return object expectation object instance
function Expectation()

  obj = {
    mockObj: invalid,
    methodName: "",

    ' set a mockObj reference
    ' @param object mockObj
    setMockObj: function( mockObj as Object )
      m.mockObj = mockObj
    end function,

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

      if ( isValid( m._mockDetails ) )

        m._mockDetails["argValues"] = argValues
        m._mockDetails.calls = m._mockDetails.calls + 1

        if ( isValid( m._mockDetails[ "returnValue" ] ) ) then return m._mockDetails[ "returnValue" ]

      end if

    end function

  }

  return obj

end function

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

' Returns the max value within an array of integers
' @param Array only integer/float type arrays are permitted
' @return Dynamic max value or invalid
function Max( collection as Object ) as Dynamic

  if ( collection.Count() = 0 ) then return invalid

  maxValue = collection[ 0 ]

  for each value in collection
    if ( value > maxValue ) then maxValue = value
  end for

  return maxValue
end function

' Returns a string representaion of the array where elements of the array are sperated by the delimiter
' @param Array only integer/float type arrays are permitted
' @param String the delimiter
' @return a string representation of the array'
function convertArrayToString( array as Object, delimiter = "," as String )


  returnValue = ""
  for i = 0 to ( array.Count() - 1 )
    value = array[ i ]
    if ( i = (array.Count() - 1) )
      returnValue = returnValue + value.toStr()
    else
      returnValue = returnValue + value.toStr() + delimiter
    end if
  end for

  return returnValue
end function

' Iterates over each element performing a tranformation on it
' @param array
' @param function transformation method
' @return array
function arrayMap( array, transform )
  returnValue = []

  for each element in array
    returnValue.push( transform(element) )
  end for

  return returnValue
end function

' Reduces the array based on the transform function
' @param array  the array of elements
' @param intialValue the intial value
' @param function transformation method
' @return array
function arrayReduce( array, intialValue, transform )

  returnValue = intialValue

  for each element in array
    returnValue = transform( returnValue, element )
  end for

  return returnValue
end function

' Filters the array based on the transform function
' @param array  the array of elements
' @param function transformation method
' @return array
function arrayFilter(array, filter)

  returnValue = []

  for each element in array
   if (filter( element ) )
      returnValue.push(element)
   end if
  end for

  return returnValue
end function


' check if the given code is within ascii range
' @param object bucket
' @param int ascCode
' @return Boolean true if in range, false otherwise
function inAscRange( bucket as Object, ascCode as Integer )
  return isInteger( bucket.start ) AND isInteger( bucket.end ) AND ( ( bucket.start <= ascCode ) AND ( bucket.end >= ascCode) )
end function

' Slices the given array
' @param object array
' @param int start index
' @param int end index
function arraySlice( array as Object, startIndex = 0 as Integer, endIndex = 0 as Integer )

  splicedArray = []

  if ( startIndex < 0 ) then return splicedArray
  if ( endIndex = 0 OR endIndex > array.Count() ) then endIndex = array.Count()

  for i = startIndex to ( endIndex - 1 )
    splicedArray.push( array[i] )
  end for

  return splicedArray
end function

' Converts assocarray to an array
' @param object assocarray
' @return object array
function convertToArray( map as object)

  values = []
  if ( isValid( map ) )
    for each item in map.Items()
        values.push( item.key.tostr() )
    end for
  end if

  return values
end function

' Converts array to a Map
' @param object array
' @return object associative array
function convertToMap( array as object )

  map = {}
  if ( isValid( array ) )
    for each item in array
      map.AddReplace( item.tostr(), item.tostr() )
    end for
  end if

  return map
end function


' Find an array element based on the given predicate
' @param object array
' @param args object
' @param predicate function
function arrayFindIndex( array as Object, args as Object, predicate as function )

  for i = 0 to ( array.Count() - 1 )
    if ( predicate( array[i], args ) ) then return i
  end for

  return -1

end function

' compares the values of two arrays
' @param array object
' @param array object
' @return boolean true if equal otherwise false
function arrayEquals( arr1 as Object, arr2 as Object )

  if ( not ( isArray( arr1 ) AND isArray( arr2 ) ) ) then return false

  if ( arr1.Count() <> arr2.Count() ) then return false

  while ( ( arr1.isNext() and arr2.isNext() ) )

    aEle = arr1.next()
    bEle = arr2.next()

    if ( type(aEle) <> type(bEle) ) then return false

    if ( LCase(type( aEle )) = "roarray" AND LCase(type( bEle )) = "roarray" )
      arrayCheckStatus = arrayEquals( aEle, bEle )
      if ( not arrayCheckStatus ) then return false
    end if

    if ( LCase(type( aEle )) = "roassociativearray" AND LCase(type( bEle )) = "roassociativearray" )
      if ( FormatJson( aEle ) <> FormatJson( bEle ) ) then return false
    end if

    if (aEle <> bEle) then return false

  end while

  return true

end function


function arraySort( targetArray as object, sourceNodeArray as object )
  sourceMap = {}
  for each item in sourceNodeArray
    sourceMap.AddReplace(item.id, item)
  end for

  sortedArray = []
  for i=0 to targetArray.count() - 1
    if ( sourceMap.DoesExist( targetArray[i] ) )
      sortedArray.push( sourceMap[ targetArray[i] ] )
    end if
  end for

  return sortedArray

end function

' Returns a clone of the given object
' @param object
' @return object Clone object of the supported type
function clone( obj as Object )

  ' Clone Transformations by Type
  _cloneByType = {

    ' Returns a cloned assoc array type
    ' @param object
    ' @return object
    associativeArray: function( obj as Object )

      cloneObj = { }

      for each item in obj.Items()
        cloneObj.AddReplace(item.key, item.value)
      end for

      return cloneObj

    end function,

    ' Returns a cloned node type
    ' @param object
    ' @return object
    node: function( obj as Object )

      newNode = CreateObject("roSGNode", obj.subtype())

      for each field in obj.getFields()
        if NOT (field = "focusedChild" OR field = "change" OR field = "focusable") then
          newNode.setField(field, obj[field])
        end if
      end for

      return newNode

    end function

  }

  if ( LCase(type( obj )) = "node" )
    return _cloneByType.node( obj )
  else if ( LCase(type( obj )) = "roassociativearray" )
    return _cloneByType.associativeArray( obj )
  else
    return obj
  end if

end function
'-----------------------------------------------------
' Contains General Utility methods'
'-----------------------------------------------------

' Checks if object is valid or not'
' @param Dynamic entity'
' @return Boolean
function isValid( entity as Dynamic ) as Boolean

  if ( (entity = invalid) or (type(entity) = "roInvalid") )
    return false
  end if

  return true
end function

' Checks if object is a string or not
' @param object string
' @return boolean
function isString( str as String ) as Boolean
  strType = LCase( type(str) )
  return ( strType = "string" ) or ( strType = "rostring" )
end function


' Checks if value is an object or not
' @param object
' @return boolean
function isObject( obj as Object ) as Boolean

  if ( not isValid( obj )) then return false

  objType = LCase( type(obj) )
  return objType = "roassociativearray"
end function


' Checks if value is a Boolean or not
' @param boolean
' @return boolean
function isBoolean( obj as Boolean ) as Boolean
  objType = LCase( type(obj) )
  return ( objType = "boolean" ) or ( objType = "roboolean" )
end function


' Checks if value is an array or not
' @param array
' @return boolean
function isArray( arr as Object ) as Boolean

  if ( not isValid( arr )) then return false

  objType = LCase( type(arr) )
  return ( objType = "roarray" ) or ( objType = "array" )
end function


' Checks if value is an Integer or not
' @param integer
' @return boolean
function isInteger( int as Integer ) as Boolean
  objType = LCase( type(int) )
  return ( objType = "integer" ) or ( objType = "roInteger" )
end function


' Returns a random UUID
' @return String
function generateUUID() as String
  return CreateObject("roDeviceInfo").GetRandomUUID()
end function


' Returns if the device is a low end device or not'
' @return Boolean'
function isLowEndDevice() as Boolean

  lowEndDeviceList = GetConstants().LOW_END_DEVICE

  deviceInfo = CreateObject("roDeviceInfo")
  modelNo = deviceInfo.GetModel()

  return ( deviceInfo.GetGraphicsPlatform() = "directfb" ) or ( lowEndDeviceList.DoesExist(Lcase(modelNo)) )
end function

' Capitalizes the first letter of the given text
' @param string text
' @return string text
function CapitalizeString( text = "" as String )

  returnValue = ""

  for each word in text.Tokenize( " " )
    returnValue += CapitalizeWord( word ) + " "
  end for

  return Left(returnValue, Len(returnValue) - 1 )
end function

' Capitalizes the first letter of the given text
' @param string text
' @return string text
function CapitalizeWord( text = "" as String )
  return UCase( Left(text, 1) ) + LCase( Right( text, Len(Text) - 1) )
end function


' Creates a shallow copy of a given node
' @param object item
' @return object new item
function shallowNodeCopy( item as Object )

  copy = CreateObject( "roSGNode", item.subtype() )

  fields = item.getFields()

  ' NOTE: Had to do this. This stops warnings thrown by Roku
  fields.Delete( "change" )
  fields.Delete( "focusedChild" )

  copy.setFields( fields )
  return copy

end function


' Returns the query joining symbol ( & or ? )
' @param string url
' @return string symbol ( & or ? )
function getQueryStringSymbol( url as String )

  symbol = "&"
  if ( ( url.Instr("?") = -1 ) ) then symbol = "?"

  return symbol
end function

' Strips html <p> and &amp from strings
' @param string s as string
' @return string cleaned String
function stripHTMLFromString( s )

  if ( not isValid(s) )
    return ""
  end if

  tagsRegEx = CreateObject( "roRegex", "<[a-zA-Z\/][^>]*>", "m" )
  s = tagsRegEx.ReplaceAll( s, "" )

  entitiesRegEx = CreateObject( "roRegex", "(&[a-zA-Z]*;)", "m" )
  s = entitiesRegEx.ReplaceAll( s, "" )

  return s

end function

' Returns the scale factor for UI for the corresponding displayType
' @return vector2D scaleFactor [x, y]
function getDisplayScaleFactor()

  ri = CreateObject("roDeviceInfo")

  deviceRes = ri.GetDisplaySize()
  resFactorY = deviceRes.h / 1080
  resFactorX = deviceRes.w / 1920

  return [ resFactorX, resFactorY ]

end function


' Returns the full screen size for UI for the corresponding displayType
' @return vector2D scaleFactor [x, y]
function getFullscreenSize()

  ri = CreateObject("roDeviceInfo")

  deviceRes = ri.GetDisplaySize()
  return [  deviceRes.w , deviceRes.h ]

end function

' Returns the device ID
' @return string
function getDeviceId()

  ri = CreateObject("roDeviceInfo")
  return ri.GetChannelClientId()

end function


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

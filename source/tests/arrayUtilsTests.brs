
' A simple case to test mockfunctions
function TestCase__ArrayMap()

  mathStub = {
    addByOne: function( item as Object )
      return item * item
    end function
  }

  ' Set up
  inpArray = [ 1, 2, 3 ]

  ' Exercise
  sqArray = arrayMap( inpArray, mathStub.addByOne )

  ' Verify
  return m.assertEqual( sqArray, [ 1, 4, 9 ] )

end function

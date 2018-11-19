
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

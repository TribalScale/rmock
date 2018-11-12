
' Application entry point
' @param args dyamic object
function main( args as Dynamic )

  port = CreateObject("roMessagePort")
  screen = CreateObject("roSGScreen")
  screen.setMessagePort(port)

  scene = screen.CreateScene("BaseScene")
  screen.show()

  ' Run Tests
  if ( ( isValid(TestRunner) and type(TestRunner) = "Function" ) )
      Runner = TestRunner()
      Runner.logger.SetVerbosity(1)
      Runner.Run()
  else
      print "No tests run"
  end if

  mainEventLoop( port )

end function


' Main Event Loop
' @param port object
function mainEventLoop( port as Object )

  while ( true )

    msg = wait(0, port)
    msgType = type(msg)

    ' Handle all the needed events here
    if ( msgType = "roSGScreenEvent" )
      if msg.isScreenClosed() then exit while
    else if ( msgType = "roSGNodeEvent" )

        field = msg.getField()
        data = msg.getData()

        print "Field - "; field; "; Value : "; data

    end if

  end while

end function

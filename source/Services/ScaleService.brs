
function ScaleService( unitConversion as object )

  service = {

    conversionSrv: unitConversion,
    measurement: 0.0,
    measurementType: "kg",

    Measure: function(unitType as string, weight as float)
      m.measurement = weight
      m.measurementType = unitType
    end function,

    DisplayMeasurement: function( unitType as string )

      if unitType = m.measurementType then return m.measurement.tostr() + m.measurementType

      if unitType = "kg" then return m.conversionSrv.lbTokg(m.measurement).tostr() + unitType

      if unitType = "lb" then return m.conversionSrv.kgTolb(m.measurement).tostr() + unitType

    end function
  }

  return service

end function

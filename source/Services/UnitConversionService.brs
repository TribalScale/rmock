
function UnitConversionService()

  services = {

    kgTolb: function(kg as float) as float
      return kg * 2.20462
    end function,

    lbTokg: function(lb as float) as float
      return lb * 0.453592
    end function

  }

  return services

end function


FUNCTION squarewave,x,low,high,period,high_fraction,x0,nterms
   y=fltarr(n_elements(x))

   L = float(period)/2.0
   w = L*float(high_fraction)

   y = y+w/L
   FOR n=1,nterms DO BEGIN
      y = y + (2.0/(n*!pi)) * sin(n*!pi*w/L) * cos(n*!pi*(x-x0)/L)
   END
   y = float(low) + y*(float(high)-float(low))

   return,y
END

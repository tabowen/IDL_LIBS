function downsample,data,rate
  d_buff=data
  rate=long(rate)

data_size=size(d_buff)
if data_size[0] eq 1 then begin

if  data_size[1] mod rate ne 0 then begin
     d_buff=data[0:(( data_size[1]/rate) *rate) -1]
endif

ref_array=reform(D_buff,long(rate),(n_elements(d_buff)/rate))

avg_ref_array=total(ref_array,1)/rate

ds_data=avg_ref_array
return ,ds_data
endif


if data_size[0] eq 2 then begin
   for i =0,data_size[2] -1 do begin
      if  data_size[1] mod rate ne 0 then begin
         buff=D_BUFF[0:(( data_size[1]/rate) *rate) -1,i]
      
         ref_array=reform(buff,long(rate),(n_elements(buff)/rate))
      ENDIF

      if  data_size[1] mod rate eq 0 then begin
          buff=D_BUFF[*,i]
          
          ref_array=reform(buff,long(rate),(n_elements(buff)/rate))
          

       endif
      avg_ref_array=total(ref_array,1)/rate

      if i eq 0 then ds_data=avg_ref_array
      if i gt 0 then ds_data=[[ds_data],[avg_ref_array]]
endfor
return, ds_data
endif

end

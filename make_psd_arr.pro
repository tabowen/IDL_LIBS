function make_psd_arr,t,arr,m,n

t=t-t[0]
if m*n ne n_elements(t) then begin
print, 'bad array size'
 return, void
endif
reform_arr=reform(arr,m,n)




fft=fft(reform_arr,dimension=1)

freqs=get_fft_freqs(m,t[1])
bandwidth=freqs[1]
psd=abs((fft)*conj(fft))/bandwidth

good_freqs=freqs[where(freqs ge 0)]
good_psd=psd[where(freqs ge 0),*]
dat=[[freqs],[psd]]
dat=[[good_Freqs],[good_psd]]
;stop
return,dat
end



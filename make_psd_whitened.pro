function make_psd_whitened,t,arr,data
;returns freqs and psd for an array
;windows array with blackmanharrs window
;gets freqs from get_fft_freqs
;makes ts even number length to avoid fft bottleneck

n_samples=n_elements(arr)

if n_samples mod 2 ne 0 then begin
   arr=arr[1:*]
   t=t[1:*]
   n_samples=n_elements(arr)
endif
;stop
;stop



t=t-t[0]
dt=t[1]

arr1=[0,arr]

darr=arr-arr1


freqs=get_fft_freqs(n_samples,dt)
      
good_freqs=freqs[where(freqs ge 0)]
 filter=4*sin(!pi*freqs*(t[1]))^2
 fourier=fft(darr,/double)
      ft=abs(fourier[where(freqs ge 0),*])
      psd=fourier[where(freqs ge 0),*]*conj(fourier[where(freqs ge 0),*])/filter
      bandwidth_normalize_psd= psd/freqs[1]
     ;total(arr*arr)=total(bandwidth_normalize_psd)*freqs[1]*n_samples



data=make_array(n_samples/2 +1,/double,3)
data[*,0]=good_freqs
data[*,1]=ft
data[*,2]=bandwidth_normalize_psd
return,data
end

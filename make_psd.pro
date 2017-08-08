function make_psd,t,arr,window=window,no_t=no_t,normalize=normalize
;returns freqs and psd for an array
;windows array with blackmanharrs window
;gets freqs from get_fft_freqs
;makes ts even number length to avoid fft bottleneck

t_buff=t
if keyword_set(no_t) then begin
arr=t
t_buff=findgen(n_elements(arr))
endif

n_samples=n_elements(arr)

if n_samples mod 2 ne 0 then begin
   arr=arr[1:*]
   t_buff=t_buff[1:*]
   n_samples=n_elements(arr)
endif
;stop
;stop

if n_elements(window) eq 1 then begin
print,'WINDOWING'
win=bh_win(n_samples)
win_arr=win*arr
endif

if n_elements(window) eq 0 then print,'NOWINDOW' & win_arr=arr

t_buff=t_buff-t_buff[0]
dt=t_buff[1]

freqs=get_fft_freqs(n_samples,dt)
      good_freqs=freqs[where(freqs ge 0)]
      fourier=fft(win_arr,/double)
      ft=abs(fourier[where(freqs ge 0),*])
      psd=abs(fourier[where(freqs ge 0),*])*abs(fourier[where(freqs ge 0),*]); (V/S)^2/N/freq
      bandwidth_normalized_psd=psd/freqs[1]
;total(arr*arr)=total(bandwidth_normalized_psd)*fs=total(BWNPSD)*n_samples*freqs[1]





      
;stop
data=make_array(n_samples/2 +1,/double,2)
data[*,0]=good_freqs
if keyword_Set(normalize) then data[*,0]=good_freqs*normalize
data[*,1]=bandwidth_normalized_psd
return,data
end

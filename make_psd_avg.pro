function make_psd_avg,t,arr,m,n,normalize=normalize

tbuff=t-t[0]
if m*n ne n_elements(t) then begin
print, 'bad array size'
return, void
endif
reform_arr=reform(arr,m,n)




fft=fft(reform_arr,dimension=1)

freqs=get_fft_freqs(m,tbuff[1])
good_freqs=freqs[where(freqs ge 0)]
bandwidth=freqs[1]
psd=abs((fft)*conj(fft))/bandwidth


avg_psd=total(psd,2)/n
good_psd=avg_psd[where(freqs ge 0)]
dat=[[good_freqs],[good_psd]]
;stop
if keyword_set(normalize)then dat[*,0]=good_freqs*normalize
return,dat
end



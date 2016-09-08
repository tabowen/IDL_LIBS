function noise_proc, t,arr,filter_size,cutoff
print,t[0]
n_samples=n_elements(t)

if n_samples mod 2 ne 0 then print, 'last point truncated'

psd=make_psd(t,arr)
print,t[0]
n_samples=n_elements(t)

medf=median_filter_psd(psd[*,0],psd[*,2],filter_size)

window,1
!p.multi=[0,0,3]
plot,medf.data[*,0],medf.data[*,1],/ylog,xtitle='Freqs Hz',ytitle='PSD V!u2!n/Hz'
oplot,medf.data[*,0],medf.data[*,2],color=50
oplot,medf.data[where(medf.data[*,3] gt cutoff),0],medf.data[where(medf.data[*,3] gt cutoff),1],color=250,psym=2

plot,medf.data[*,0],medf.data[*,1],/ylog,xtitle='Freqs Hz',ytitle='PSD V!u2!n/Hz'
oplot,medf.data[where(medf.data[*,3] le cutoff),0],medf.data[where(medf.data[*,3] le cutoff),1],color=50,psym=2


plot,medf.data[*,0],medf.data[*,3],yrange=[1e-1,1e2],/ylog,ytitle='Normal Power',xtitle='Freqs Hz'
!p.multi=0
;stop
norm=medf.data[*,3]
med=medf.data[*,2]

window,2
pdf=make_pdf(norm,n_elements(t))

j=0L
sum=0.0
while sum lt .95*n_elements(t)/2 +1 do begin
sum=sum+pdf[1,j] 
j++
endwhile
print,pdf[0,j]

plot,pdf[0,*],pdf[1,*],/ylog,xrange=[1e-3,1e2],yrange=[1e-1,1000],/xlog
;stop
window,3
plot,medf.data[*,0],medf.data[*,1],/ylog,xtitle='Freqs Hz',ytitle='PSD V!u2!n/Hz',/xlog,xrange=[(medf.data[1,0]),max(medf.data[*,0])]
oplot,medf.data[where(medf.data[*,3] gt cutoff),0],medf.data[where(medf.data[*,3] gt cutoff),1],color=50,psym=2

;stop
reverse_norm=norm[1:*];remove dc
reverse_norm=reverse(reverse_norm)

full_norm=[norm,reverse_norm[1:*]]



noise_inds=where(full_norm gt cutoff)
sig_inds=where(full_norm le cutoff)

fft_arr=fft(arr)
fft_freqs=get_fft_freqs(n_elements(arr),t[1])
sig_spec=fft_arr
noise_spec=fft_arr

interpol_sig=interpolate_noise(fft_freqs,sig_spec,noise_inds,filter_size)

;stop
sig_spec[noise_inds]=complex(0,0)
noise_spec[sig_inds]=complex(0,0)
;stop
signal=fft(sig_spec,1,/double)
noise=fft(noise_spec,1,/double)
interpol_signal=fft(interpol_sig,1,/double)
;stop
signal=float(signal)
noise=float(noise)
window,4
!p.multi=[0,0,3]
plot,t,arr
plot,t,signal,color=50
plot,t,noise,color=250
!p.multi=0
;stop
n_s=[[noise],[signal],[interpol_signal]]
return,n_s
end








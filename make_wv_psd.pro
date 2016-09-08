function wavelet_psd,t,arr,order,nscale,log_space,start_scale

t=t-t[0]
n_samples=n_elements(t)
IF N_ELEMENTS(start_scale) eq 0 then start_scale=2

bandwidth=1.0/t[1]/n_samples

wave=wv_cwt(arr,'Morlet',order,scale=scales,nscale=nscale,dscale=log_space,start_scale=start_scale)

wavepow=abs(wave*wave)
                                
freq=order/(2*!dpi*t[1]*scales) 
power=total(wavepow,1)
norm=1.0/(float(n_samples)*n_samples*bandwidth)
;stop
wavelet={Wave_PSD:power,freqs:freq,norm:norm,scales:scales,order:order,log_space:log_space,start_scale:start_scale}
return, wavelet

end

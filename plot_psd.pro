pro plot_psd,psd,d, ylog=ylog,xlog=xlog, oplot=oplot,color=color,psym=psym,linesty=linesty,xrange=xrange,yrange=yrange,wavelet=wavelet, debug=debug,detrend=detrend,nodata=nodata,adjust=adjust,title=title,xtitle=xtitle,ytitle=ytitle,ps=ps,png=png,file=file,ymargin=ymargin,xmargin=xmargin,subtitle=subtitle,thick=thick,ytickformat=ytickformat,smooth_bins=smooth_bins,offset=offset,period=period,o1psd=o1psd

psd_buff=psd

if keyword_set(wavelet) eq 1 then begin
wvfreqs=psd_buff.freqs
power=psd.wave_psd*psd.norm

psd_buff=make_array(n_elements(wvfreqs),2,/double)
psd_buff[*,0]=reverse(wvfreqs)
psd_buff[*,1]=reverse(power)
endif

if keyword_set(d) then begin
psd_buff=[[psd_buff[*,0]],[psd_buff[*,d]]]
endif


if keyword_set(o1psd) eq 1 then begin
   psd_buff[*,1]=sqrt(psd_buff[*,1])
endif

if keyword_set(adjust) eq 1 then begin
   psd_buff[*,1]=psd_buff[*,1]*adjust
endif

if keyword_set(detrend) eq 1 then begin
   psd_buff[*,1]=psd_buff[*,1]*(psd_buff[*,0])^(detrend)
endif

if keyword_set(offset) eq 1 then begin
   psd_buff[*,1]=psd_buff[*,1]*offset
endif

if keyword_set(smooth_bins) eq 1 then psd_buff[*,1]=smooth(psd_buff[*,1],smooth_bins)

bandwidth=psd_buff[1,0]
nyquist=max(psd_buff[*,0])

if keyword_Set(period) eq 1 then psd_buff[1:*,0]=1.0/psd_buff[1:*,0]

strcommand='plot,psd_buff[*,0],psd_buff[*,1],xrange=xrange,yrange=yrange' 



if keyword_set(xrange) eq 0 and keyword_set(period) eq 0 then xrange=[bandwidth,nyquist]
if keyword_set(xrange) eq 0 and keyword_set(period) eq 1 then xrange=[1/nyquist,1/bandwidth]
if keyword_set(yrange) eq 0 then yrange=[min(psd_buff[*,1]),max(psd_buff[*,1])]

if keyword_set(xlog) then strcommand=strcommand+',/xlog'
if keyword_set(ylog) then strcommand=strcommand+',/ylog'

if keyword_set(title) then strcommand=strcommand+',title=string('+string(39B)+title+string(39B)+')'

if keyword_set(xtitle) then strcommand=strcommand+',xtitle=string('+string(39B)+xtitle+string(39B)+')'

if keyword_set(ytitle) then strcommand=strcommand+',ytitle=string('+string(39B)+ytitle+string(39B)+')'

if keyword_set(subtitle) then strcommand=strcommand+',subtitle=string('+string(39B)+subtitle+string(39B)+')'
;stop
if keyword_set(thick) then strcommand=strcommand+strcompress(',thick='+string(thick),/remove_all)
if keyword_set(ytickformat) then strcommand=strcommand+strcompress(',thick='+string(ytickformat),/remove_all)
;stop

if keyword_set(xmargin) then strcommand=strcommand+',xmargin=xmargin'
if keyword_set(ymargin) then strcommand=strcommand+',ymargin=ymargin'



if keyword_set(oplot) then strcommand='oplot,psd_buff[*,0],psd_buff[*,1]'


if keyword_set(color) then strcommand=strcommand+strcompress(',color='+string(color),/remove_all)
if keyword_set(psym) then strcommand=strcommand+strcompress(',psym='+string(psym),/remove_all)
if keyword_set(linesty) then strcommand=strcommand+strcompress(',linesty='+string(linesty),/remove_all)
if keyword_set(nodata) then strcommand=strcommand+',/nodata'


;if (KEYWORD_SET(xlog) eq 0 and if (KEYWORD_SET(ylog) eq 0 then strcommand='plot,psd[*,0],psd[*,2],xrange=xrange'
;print,xr
 if keyword_set(debug) eq 1 then print,strcommand


if keyword_Set(file) then filename=strcompress(file)
if keyword_Set(file) eq 0 then filename=strcompress('PSD_plot_'+systime())
if keyword_set(ps) eq 1 then begin
set_plot,'ps'
device, filename=filename,/landscape,/color,/HELVETICA, /NARROW, /BOLD
endif

void = EXECUTE(strcommand)


if keyword_set(ps) eq 1 then begin
device, /close
set_plot,'x'
endif
if keyword_set(png) eq 1 then begin
set_plot,'x'
write_png,filename,tvrd(/true)
endif

end

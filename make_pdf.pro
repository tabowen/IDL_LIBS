
function make_pdf,normal_psd,bins,max=max,min=min,norm=norm


n_bins=double(bins)
if keyword_set(max) eq 1 then max_normal_power=max
if keyword_set(max) eq 0 then max_normal_power=max(normal_psd)

if keyword_set(min) eq 1 then min_normal_power=min
if keyword_set(min) eq 0 then min_normal_power=min(normal_psd)




binsize=(max_normal_power-min_normal_power)/(n_bins-1)
xvals=findgen(n_bins)*binsize +min_normal_power

hist=histogram(normal_psd,max=max_normal_power,min=min_normal_power,nbins=n_bins,/nan)
pdf=hist
if keyword_set(norm) then pdf=pdf/double(n_elements(normal_psd))
data=make_array(n_bins,2)
data[*,0]=xvals
data[*,1]=pdf
return,data
end

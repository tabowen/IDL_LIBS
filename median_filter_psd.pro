function median_filter_psd,freqs,psd,filter_size
;given psd, freqs, and median filter size, returns
;psd,filtered psd,frequencies,normalized_psd


filtered_psd=psd
normal_psd=psd
n_samples=n_elements(psd)

 start_j=long(filter_size/2)
 end_j=long(n_samples-1-filter_size/2)

j=0L
filter_min=j-(filter_size)/2
while j lt n_samples-1 do begin
   filter_center=j
   filterl=reverse(filter_center-findgen(filter_size/2)-1)
   filterr=filter_center+findgen(filter_size/2)+1
   filter_inds=abs([filterl,filter_center,filterr])
   ;print,filter_inds
   
   high_inds=where(filter_inds gt n_samples -1,nhighinds)
   
   if nhighinds gt 0 then filter_inds[high_inds]=(n_samples-2) -(filter_inds[high_inds]-n_samples)


filter=psd[filter_inds]
  ; if (i mod 1000) eq 0 then stop
   filtered_psd[j]=median(filter)
;print,fix(filter_inds)
;stop
j++
filter_min=j-(filter_size)/2.0
endwhile

normal_psd=psd/filtered_psd
data=make_array(n_elements(psd),4)
data[*,0]=freqs
data[*,1]=psd
data[*,2]=filtered_psd

data[*,3]=normal_psd

names=['f','psd','filtered_psd','normal_psd']  
med_filter={f:freqs,psd:psd,fpsd:filtered_psd,npsd:normal_psd,filter:filter_size}
return,med_filter
end

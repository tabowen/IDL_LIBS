function find_harmonics, noise_inds



inds_buffer=noise_inds
harmonic_count=0
check=0
harmonics=[0]

for i =0,n_elements(Noise_inds)-1 do begin
if inds_buffer[i] ne 0 then begin
harmonic_finder=where(noise_inds mod(inds_buffer[i]) eq 0)
if n_elements(harmonic_finder) gt 1 then begin

   harmonics=[harmonics,noise_inds[harmonic_finder]]
   harmonic_count=harmonic_count+n_elements(harmonic_finder)
   check++
print,string(inds_buffer[i])+ 'index has'+string(n_elements(harmonic_finder))+'harmonics'
endif
inds_buffer[harmonic_finder]=0 
endif
endfor
harmonics=harmonics[1:*]
return, harmonics
end

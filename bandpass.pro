function bandpass, t,arr,lb,ub

t=t-t[0]
bp_arr=arr
size_arr=size(arr)
iterations=0
if size_arr[0] gt 1 then iterations =size_arr[2]

for i=0,iterations do begin
   arr_buff=arr[*,iterations]
   fftarr=fft(arr_buff)
   freqs=get_fft_freqs(arr_buff,t[1])
   

   fftarr[where(freqs gt ub)]=0

   fftarr[where(freqs lt -1*(ub))]=0


   fftarr[where(freqs lt lb and freqs gt (-1)*lb)]=0



   bp_arr[*,i]=fft(fftarr,/inverse)
endfor
return,bp_arr
end

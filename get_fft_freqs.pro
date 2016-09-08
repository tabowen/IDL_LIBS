function get_fft_freqs, n_samples,dt,fs=fs
if n_elements(n_samples) gt 1 then n=n_elements(n_samples)

if n_elements(n_samples) eq 1 then n=n_samples

t=dt
if keyword_set(fs) then t=1.0/dt

X = FINDGEN((N - 1)/2) + 1
is_N_even = (N MOD 2) EQ 0
if (is_N_even) then $
  freqs = [0.0, X, N/2, -N/2 + X]/(N*T) $
else $
  freqs = [0.0, X, -(N/2 + 1) + X]/(N*T)

return, freqs

end

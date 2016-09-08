function make_t,length,dt
n_samples=length
if n_elements(n_samples) gt 1 then n_samples =N_elements(n_samples)
t=findgen(n_samples)*dt

return,t

end

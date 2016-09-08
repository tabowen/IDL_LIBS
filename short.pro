function short,array,dim=dim
if keyword_set(dim) eq 0 then dim=1

dim_arr=dimension(array)
ind_arr=replicate(',0',dim_arr)
ind_arr[dim-1]=',*'
compress_str=strjoin([ind_arr,']'])
strput,compress_str,'[',0





string='subarr=array'+compress_str
void=execute(string)

n=n_elements(subarr)
int=uint(alog(n)/alog(2))




short_arr=replicate(',*',dim_arr)
short_arr[dim-1]=',0:2.0^int -1.0'
compress_str=strjoin([short_arr,']'])
strput,compress_str,'[',0

string='short_arr=array'+compress_str
void=execute(string)

return,short_arr
end

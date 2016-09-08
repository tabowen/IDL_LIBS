function bh_win,n_elements

 init_bh_win=findgen(n_elements)
   bh_win=.35875 -.48829*cos(init_bh_win*2*!dpi/(n_elements-1)) + .14128*cos(init_bh_win*4*!dpi/(n_elements-1))-.01168*cos(init_bh_win*6*!dpi/(n_elements-1))
   
   alpha=.05
   t_win=findgen(n_elements)
   t_win[0: alpha*(n_elements -1)/2]=.5*(1+cos(!dpi*(2*t_win[0: alpha*(n_elements -1)/2]/(alpha*(n_elements-1))-1)))

   t_win[alpha*(n_elements -1)/2 +1:(n_elements -1)*(1-(alpha/2))]=1
   t_win[(n_elements-1)*(1-(alpha/2))+1:*]=.5*(1+cos(!dpi*(2*t_win[(n_elements -1)*(1-(alpha/2))+1:*]/(alpha*(n_elements-1)) -2/alpha +1)))

return, t_win

end

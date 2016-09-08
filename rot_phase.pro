function rot_phase,x,y,angle,rad=rad
;stop
angle_rad=angle*(!pi/180)
if keyword_set(rad) then angle_rad=angle
;x=replicate(1.0,100)
;y=make_array(100)
vec=[[x],[y]]
vec=transpose(vec)

;angle=replicate(!pi,100)
rot_matrix=make_array(2,2,n_elements(angle_rad),/double)
rot_matrix[0,0,*]=cos(angle_rad)
rot_matrix[0,1,*]=-1*sin(angle_rad)
rot_matrix[1,0,*]=sin(angle_rad)
rot_matrix[1,1,*]=cos(angle_rad)

rot_vec=vec
for i=0,n_elements(angle)-1 do rot_vec[*,i]=rot_matrix[*,*,i]#vec[*,i]
rot_vec_t=transpose(rot_vec)


return, rot_vec_t
end






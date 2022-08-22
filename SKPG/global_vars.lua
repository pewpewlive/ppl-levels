local global_vars = {}
width = 850fx
height = 650fx
int_width = fmath.to_int(width)
int_height = fmath.to_int(height)
table.insert(global_vars,{width,height})
table.insert(global_vars,{int_width,int_height})
return global_vars
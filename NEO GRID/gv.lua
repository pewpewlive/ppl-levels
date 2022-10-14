local global_vars = {}--This is not only useful in making 1 level, but when you make another one everything depends on this one file, and everything changes depending on this file, very nice
width = 1300fx
height = 1300fx
int_width = fmath.to_int(width)
int_height = fmath.to_int(height)
table.insert(global_vars,{width,height})
table.insert(global_vars,{int_width,int_height})
return global_vars

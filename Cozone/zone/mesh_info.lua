local a = 240
local z = 20
local int_mesh_info = {--for the purpose of being organized, every polygon starts from the top left and goes clock-wise to the bottom left
    {
        {-a,-a,-z*2},{a,-a,-z*2},{a,a,-z*2},{-a,a,-z*2},
        {-a,-a,-z},{a,-a,-z},{a,a,-z},{-a,a,-z},
        {-a,-a,z},{a,-a,z},{a,a,z},{-a,a,z},
        {-a,-a,z*2},{a,-a,z*2},{a,a,z*2},{-a,a,z*2},
    },
    {
        {-a,-a,-z*2},{a,-a,-z*2},{a,a,-z*2},{-a,a,-z*2},
        {-a,-a,-z},{a,-a,-z},{a,a,-z},{-a,a,-z},
        {-a,-a,z},{a,-a,z},{a,a,z},{-a,a,z},
        {-a,-a,z*2},{a,-a,z*2},{a,a,z*2},{-a,a,z*2},
    }
}

local resize = 1.1
for i = 1, #int_mesh_info[2] do
    int_mesh_info[2][i][1] = int_mesh_info[2][i][1] * resize
    int_mesh_info[2][i][2] = int_mesh_info[2][i][2] * resize
    if i % 2 == 0 then
        int_mesh_info[2][i][2] = 0
    else 
        int_mesh_info[2][i][1] = 0
    end
end

return int_mesh_info
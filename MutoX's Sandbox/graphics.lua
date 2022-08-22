local width = 500
local height = 500

local width2 = width / 2
local height2 = height / 2

local wwidth2 = 2000/2
local wheight2 = 2000/2

local wwwidth2 = 800/2
local wwheight2 = 800/2

local wwwwidth2 = 200/2
local wwwheight2 = 200/2

meshes = {
    {
        vertexes = {{-width2,-height2},{width2,-height2},{width2,height2},{-width2,height2}},
        segments = {{0,1,2,3,0}},
        colors = {0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff}
    },
    {
        vertexes = {{-600,-600},{600,-600},{600,600},{-600,600}},
        segments = {{0,1,2,3,0}},
        colors = {0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff}
    },
    {
        vertexes = {{-800/2,-1500/2},{800/2,-1500/2},{800/2,1500/2},{-800/2,1500/2}},
        segments = {{0,1,2,3,0}},
        colors = {0x0000ffff,0x0000ffff,0x0000ffff,0x0000ffff}
    },
    {
        vertexes = {{-150,-150},{150,-150},{150,150},{-150,150}},
        segments = {{0,1,2,3,0}},
        colors = {0xffff00ff,0xffff00ff,0xffff00ff,0xffff00ff}
    },
    {
        vertexes = {{-700,-350},{700,-350},{700,350},{-700,350}},
        segments = {{0,1,2,3,0}},
        colors = {0xffffffff,0xffffffff,0xffffffff,0xffffffff}
    },
    {
        vertexes = {{-225,-200},{225,-200},{225,200},{-225,200}},
        segments = {{0,1,2,3,0}},
        colors = {0xffffffff,0xffffffff,0xffffffff,0xffffffff}
    },
    {
        vertexes = {{-wwidth2,-wheight2},{wwidth2,-wheight2},{wwidth2,wheight2},{-wwidth2,wheight2}},
        segments = {{0,1,2,3,0}},
        colors = {0xffffffff,0xffffffff,0xffffffff,0xffffffff}
    },
    {
        vertexes = {{-wwwidth2,-wwheight2},{wwwidth2,-wwheight2},{wwwidth2,wwheight2},{-wwwidth2,wwheight2}},
        segments = {{0,1,2,3,0}},
        colors = {0xff00ffff,0xff00ffff,0xff00ffff,0xff00ffff}
    },
    {
        vertexes = {{-width2,-height2},{width2,-height2},{width2,height2},{-width2,height2}},
        segments = {{0,1,2,3,0}},
        colors = {0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff}
    },
    {
        vertexes = {{-wwwwidth2,-wwwheight2},{wwwwidth2,-wwwheight2},{wwwwidth2,wwwheight2},{-wwwwidth2,wwwheight2}},
        segments = {{0,1,2,3,0}},
        colors = {0xffffffff,0xffffffff,0xffffffff,0xffffffff}
    },
}
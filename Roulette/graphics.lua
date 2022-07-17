local width = 750
local height = 600

local width2 = width / 2
local height2 = height / 2

local redz = 50
local red = 45
local Z = 70
local z = 15
local BIG = 16

local greenz = 50


meshes = {
    {--blue theme
        vertexes = {{-width2,-height2},{width2,-height2},{width2,height2},{-width2,height2},--outline
        {-200,height2},{-150,height2 + 50, -75},{150,height2 + 50,-75},{200,height2},--up
        {-200,-height2},{-150,-height2 - 50, -75},{150,-height2 - 50,-75},{200,-height2},--down

        {width2,-125},{width2 + 50,-75,-75},{width2 + 50, 75, -75},{width2,125},--right
        {-width2,-125},{-width2 - 50,-75,-75},{-width2 - 50, 75, -75},{-width2,125},--left

        {0,0,-10000},--lines extending down


        
        {-width2 - 50,height2 + 50, -75},{width2 + 50,height2 + 50,-75},{width2 + 50,-height2 - 50,-75},{-width2 - 50,-height2 - 50, -75},--outer outline
        {-150,height2 + 50, -75},{-100,height2 + 100, -150},{100,height2 + 100,-150},{150,height2 + 50, -75},--up
        {-150,-height2 - 50, -75},{-100,-height2 - 100, -150},{100,-height2 - 100,-150},{150,-height2 - 50, -75},--down

        {width2 + 50,-75,-75},{width2 + 100,-25,-150},{width2 + 100, 25, -150},{width2 + 50,75,-75},--right
        {-width2 - 50,-75,-75},{-width2 - 100,-25,-150},{-width2 - 100, 25, -150},{-width2 - 50,75,-75},--left
        
        {-width2 - 100,height2 + 100, -150},{width2 + 100,height2 + 100,-150},{width2 + 100,-height2 - 100,-150},{-width2 - 100,-height2 - 100, -150},--outer outline2

        {-650,-125,-50},{-650,125,-50},{-900,125,-50},{-900,-125,-50},--left
        {-700,-75},{-700,75},{-850,75},{-850,-75},

        {650,-125,-50},{650,125,-50},{900,125,-50},{900,-125,-50},--right
        {700,-75},{700,75},{850,75},{850,-75},


        {-125,-550,-50},{125,-550,-50},{125,-800,-50},{-125,-800,-50},--bottom
        {-75,-600},{75,-600},{75,-750},{-75,-750},

        {-125,550,-50},{125,550,-50},{125,800,-50},{-125,800,-50},--bottom
        {-75,600},{75,600},{75,750},{-75,750},
        },

        segments = {{0,1,2,3,0},--outline
        {4,5,6,7},--up
        {8,9,10,11},--down

        {12,13,14,15},--right
        {16,17,18,19},--left

        {5,20},{6,20},{9,20},{10,20},{13,20},{14,20},{17,20},{18,20},--lines extending down



        {21,22,23,24,21},--outer outline
        {25,26,27,28},--up
        {29,30,31,32},--down

        {33,34,35,36},--right
        {37,38,39,40},--left

        {26,20},{27,20},{30,20},{31,20},{34,20},{35,20},{38,20},{39,20},--lines extending down

        {41,42,43,44,41},--outer outline2
    
        
        {45,46,47,48,45},--left
        {45,20},{46,20},{47,20},{48,20},
        {49,50,51,52,49},
        {45,49},{46,50},{47,51},{48,52},

        {53,54,55,56,53},--right
        {53,20},{54,20},{55,20},{56,20},
        {57,58,59,60,57},
        {53,57},{54,58},{55,59},{56,60},
        
        {61,62,63,64,61},--bottom
        {61,20},{62,20},{63,20},{64,20},
        {65,66,67,68,65},
        {61,65},{62,66},{63,67},{64,68},

        {69,70,71,72,69},
        {69,20},{70,20},{71,20},{72,20},
        {73,74,75,76,73},
        {69,73},{70,74},{71,75},{72,76},
        },
        colors = {0x0000ffff,0x0000ffff,0x0000ffff,0x0000ffff,--outline
        0x0000ffff,0x0000ffff,0x0000ffff,0x0000ffff,--up
        0x0000ffff,0x0000ffff,0x0000ffff,0x0000ffff,--down

        0x0000ffff,0x0000ffff,0x0000ffff,0x0000ffff,--right
        0x0000ffff,0x0000ffff,0x0000ffff,0x0000ffff,--left

        0x000000ff,--lines extending down



        0x000070ff,0x000070ff,0x000070ff,0x000070ff,--outer outline
        0x000070ff,0x000070ff,0x000070ff,0x000070ff,--up
        0x000070ff,0x000070ff,0x000070ff,0x000070ff,--down

        0x000070ff,0x000070ff,0x000070ff,0x000070ff,--right
        0x000070ff,0x000070ff,0x000070ff,0x000070ff,--left

        0x000030ff,0x000030ff,0x000030ff,0x000030ff,--outer outline
        
        
        0x000080ff,0x000080ff,0x000080ff,0x000080ff,--left
        0x0000ffff,0x0000ffff,0x0000ffff,0x0000ffff,

        0x000080ff,0x000080ff,0x000080ff,0x000080ff,--right
        0x0000ffff,0x0000ffff,0x0000ffff,0x0000ffff,

        0x000080ff,0x000080ff,0x000080ff,0x000080ff,--bottom
        0x0000ffff,0x0000ffff,0x0000ffff,0x0000ffff,

        0x000080ff,0x000080ff,0x000080ff,0x000080ff,--top
        0x0000ffff,0x0000ffff,0x0000ffff,0x0000ffff,
        }
    },
    {--red theme
        vertexes = {{-width2,-height2},{width2,-height2},{width2,height2},{-width2,height2},--outline
        {-width2,-height2,redz},{width2,-height2,redz},{width2,height2,redz},{-width2,height2,redz},--outline2
        {-width2,-height2,redz*2},{width2,-height2,redz*2},{width2,height2,redz*2},{-width2,height2,redz*2},--outline3
        {-width2,-height2,redz*3},{width2,-height2,redz*3},{width2,height2,redz*3},{-width2,height2,redz*3},--outline4
        {-width2,-height2,redz*4},{width2,-height2,redz*4},{width2,height2,redz*4},{-width2,height2,redz*4},--outline5


        {-width2,-1000,redz*4},{-width2,1000,redz*4},--ll1
        {-width2 - 100,-1000,redz*4},{-width2 - 100,1000,redz*4},--ll2
        {-width2 - 200,-1000,redz*4},{-width2 - 200,1000,redz*4},--ll3
        {-width2 - 300,-1000,redz*4},{-width2 - 300,1000,redz*4},--ll4
        {-width2 - 400,-1000,redz*4},{-width2 - 400,1000,redz*4},--ll5

        {width2,-1000,redz*4},{width2,1000,redz*4},--Rl1
        {width2 + 100,-1000,redz*4},{width2 + 100,1000,redz*4},--Rl2
        {width2 + 200,-1000,redz*4},{width2 + 200,1000,redz*4},--Rl3
        {width2 + 300,-1000,redz*4},{width2 + 300,1000,redz*4},--Rl4
        {width2 + 400,-1000,redz*4},{width2 + 400,1000,redz*4},--Rl4

        {1000,height2,redz*4},{-1000,height2,redz*4},--UL1
        {1000,height2+100,redz*4},{-1000,height2+100,redz*4},--UL2
        {1000,height2+200,redz*4},{-1000,height2+200,redz*4},--UL3
        {1000,height2+300,redz*4},{-1000,height2+300,redz*4},--UL4

        {1000,-height2,redz*4},{-1000,-height2,redz*4},--DL1
        {1000,-height2-100,redz*4},{-1000,-height2-100,redz*4},--DL2
        {1000,-height2-200,redz*4},{-1000,-height2-200,redz*4},--DL3
        {1000,-height2-300,redz*4},{-1000,-height2-300,redz*4},--DL4


        {-width2+red,-height2+red},{width2-red,-height2+red},{width2-red,height2-red},{-width2+red,height2-red},--inline
        {-width2+red*2,-height2+red*2},{width2-red*2,-height2+red*2},{width2-red*2,height2-red*2},{-width2+red*2,height2-red*2},--inline2
        {-width2+red*3,-height2+red*3},{width2-red*3,-height2+red*3},{width2-red*3,height2-red*3},{-width2+red*3,height2-red*3},--inline3
        {-width2+red*4,-height2+red*4},{width2-red*4,-height2+red*4},{width2-red*4,height2-red*4},{-width2+red*4,height2-red*4},--inline4


        {-width2+red*5,-height2+red*5},{width2-red*5,-height2+red*5},{width2-red*5,height2-red*5},{-width2+red*5,height2-red*5},--box
        {-width2+red*5,-height2+red*5,redz},{width2-red*5,-height2+red*5,redz},{width2-red*5,height2-red*5,redz},{-width2+red*5, height2-red*5,redz},--box2
        {-width2+red*5,-height2+red*5,redz*2},{width2-red*5,-height2+red*5,redz*2},{width2-red*5,height2-red*5,redz*2},{-width2+red*5, height2-red*5,redz*2},--box3
        {-width2+red*5,-height2+red*5,redz*3},{width2-red*5,-height2+red*5,redz*3},{width2-red*5,height2-red*5,redz*3},{-width2+red*5, height2-red*5,redz*3},--box4
        {-width2+red*5,-height2+red*5,redz*4},{width2-red*5,-height2+red*5,redz*4},{width2-red*5,height2-red*5,redz*4},{-width2+red*5, height2-red*5,redz*4},--box5
        },
        segments = {{0,1,2,3,0},--outline
        {4,5,6,7,4},--outline2
        {8,9,10,11,8},--outline3
        {12,13,14,15,12},--outline4
        {16,17,18,19,16},--outline5

        {20,21},--ll1
        {22,23},--ll2
        {24,25},--ll3
        {26,27},--ll4

        {28,29},--Rl1
        {30,31},--Rl2
        {32,33},--Rl3
        {34,35},--Rl4

        {36,37},--Ul1
        {38,39},--Ul2
        {40,41},--Ul3
        {42,43},--Ul4

        {44,45},--Dl1
        {46,47},--Dl2
        {48,49},--Dl3
        {50,51},--Dl4

        {52,53},--ll5
        {54,55},--Rl5


        {56,57,58,59,56},--inline
        {60,61,62,63,60},--inline2
        {64,65,66,67,64},--inline3
        {68,69,70,71,68},--inline4


        {72,73,74,75,72},--box
        {76,77,78,79,76},--box2
        --{72,88},{73,89},{74,90},{75,91},--box_connections
        {80,81,82,83,80},--box3
        {84,85,86,87,84},--box4
        {88,89,90,91,88},--box5
        },
        colors = {0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,--outline
        0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,--outline2
        0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,--outline3
        0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,--outline4
        0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,--outline5

        0xff0000ff,0xff0000ff,--ll1
        0xff0000ff,0xff0000ff,--ll2
        0xff0000ff,0xff0000ff,--ll3
        0xff0000ff,0xff0000ff,--ll4
        
        0xff0000ff,0xff0000ff,--Rl1
        0xff0000ff,0xff0000ff,--Rl2
        0xff0000ff,0xff0000ff,--Rl3
        0xff0000ff,0xff0000ff,--Rl4
        
        0xff0000ff,0xff0000ff,--Ul1
        0xff0000ff,0xff0000ff,--Ul2
        0xff0000ff,0xff0000ff,--Ul3
        0xff0000ff,0xff0000ff,--Ul4

        0xff0000ff,0xff0000ff,--Dl1
        0xff0000ff,0xff0000ff,--Dl2
        0xff0000ff,0xff0000ff,--Dl3
        0xff0000ff,0xff0000ff,--Dl4

        0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,--inline
        0xff000080,0xff000080,0xff000080,0xff000080,--inline2
        0xff000060,0xff000060,0xff000060,0xff000060,--inline3
        0xff000030,0xff000030,0xff000030,0xff000030,--inline4
        0xff000015,0xff000015,0xff000015,0xff000015,--inline5

        0xff000015,0xff000015,0xff000015,0xff000015,--box
        0xff000030,0xff000030,0xff000030,0xff000030,--box2
        0xff000060,0xff000060,0xff000060,0xff000060,--box3
        0xff000080,0xff000080,0xff000080,0xff000080,--box4
        0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,--box4
        }
    },
    {--green theme
        vertexes = {{-375,-300},{375,-300},{-375,300},{375,300},{-578.392,140.965},{-375,0},{0,300},{375,0},{0,-300},{-386.955,602.38},{-73.306,735.686,-82.206},{-151.849,511.521,-67.898},{167.749,507.501,46.431},{437.488,706.172,79.865},{677.001,452.507,106.73},{440.973,1034.872,-82.258},{-102.578,1030.87,-119.553},{855.849,665.385,17.918},{798.679,957.295,-79.174},{1238.798,817.348,-71.658},{593.121,199.377,47.062},{886.643,-30.168},{964.708,184.426,69.137},{1070.41,515.174},{1268.446,316.311,-104.412},{620.414,-168.651,42.231},{928.864,-352.811},{1125.18,-191.21},{1302.184,-370.739,-95.108},{693.57,-512.38},{402.395,-726.508,35.55},{1001.715,-784.709,-111.886},{204.634,-593.272,-52.046},{-103.429,-692.409,-38.905},{288.283,-942.775,-90.092},{-333.762,-966.479,-184.219},{-191.767,-492.141,34.95},{-517.475,-600.368},{-752.787,-446.464},{-906.802,-704.13,-97.87},{-726.333,-200.681,98.388},{-858.889,-28.877},{-1112.547,296.987,-98.886},{-1103.084,-107.336,-100.137},{-1081.95,-402.85,-53.959},{-641.411,431.869,62.318},{-1077.924,548.608,-129.323},{-905.028,812.83,-79.761},{-591.43,917.964,-107.523},
        {0,-height2,-greenz*1},{0,-height2,-greenz*2},{0,-height2,-greenz*3},{0,-height2,-greenz*4},--down
        {width2,0,-greenz*1},{width2,0,-greenz*2},{width2,0,-greenz*3},{width2,0,-greenz*4},--right
        {0,height2,-greenz*1},{0,height2,-greenz*2},{0,height2,-greenz*3},{0,height2,-greenz*4},--up
        {-width2,0,-greenz*1},{-width2,0,-greenz*2},{-width2,0,-greenz*3},{-width2,0,-greenz*4},--left
        },
        
        segments = {{37,38},{38,39},{5,40},{40,41},{41,42},{42,43},{39,44},{4,45},{45,46},{46,47},{9,48},{12,10},{20,3},{12,3},{11,12},{12,13},{20,14},{45,9},{13,15},{10,13},{29,31},{3,14},{14,17},{14,13},{28,31},{26,29},{26,21},{27,21},{24,21},{23,14},{23,24},{20,23},{25,7},{1,25},{25,26},{25,20},{25,21},{17,19},{13,17},{13,18},{15,18},{10,15},{10,16},{16,48},{45,47},{9,47},{47,48},{4,40},{4,41},{42,45},{4,42},{0,40},{8,36},{1,32},{32,36},{29,32},{5,0},{30,32},{8,1},{32,34},{7,3},{30,34},{6,2},{33,35},{2,4},{33,36},{2,5},{33,37},{3,6},{35,37},{1,7},{0,37},{0,8},{0,38},{2,9},{38,40},{4,5},{37,39},{9,10},{38,44},{10,11},{40,44},{6,12},{41,44},{11,9},{43,44},{6,11},{41,43},{11,2},{42,46},{45,2},{35,39},{48,10},{31,34},{3,13},{19,24},{15,16},{22,20},{17,23},{17,18},{18,19},{7,20},{20,21},{21,22},{27,24},{22,23},{24,22},{29,25},{26,28},{26,31},{26,27},{27,28},{24,28},{1,29},{29,30},{30,31},{19,23},{8,32},{32,33},{33,34},{34,35},{0,36},{36,37},
        {0,49,1},{0,50,1},{0,51,1},{0,52,1},--down
        {1,53,3},{1,54,3},{1,55,3},{1,56,3},--right
        {3,57,2},{3,58,2},{3,59,2},{3,60,2},--up
        {0,61,2},{0,62,2},{0,63,2},{0,64,2},--left
        {51,55,59,63,51},
        {52,56,60,64,52},
        },
        colors = {0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,
        0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,0x00ff00ff,
        0x00ff0080,0x00ff0060,0x00ff0040,0x00ff0020,--down
        0x00ff0080,0x00ff0060,0x00ff0040,0x00ff0020,--right
        0x00ff0080,0x00ff0060,0x00ff0040,0x00ff0020,--up
        0x00ff0080,0x00ff0060,0x00ff0040,0x00ff0020,--left
        }

    },
    {--pink theme
        vertexes = {{-width2,-height2},{width2,-height2},{width2,height2},{-width2,height2},--outline
        {-width2+50,-height2},{-width2+50,height2},
        {-width2+100,-height2},{-width2+100,height2},
        {-width2+150,-height2},{-width2+150,height2},
        {-width2+200,-height2},{-width2+200,height2},

        {-width2+250,-height2},{-width2+250,height2},
        {-width2+300,-height2},{-width2+300,height2},
        {-width2+350,-height2},{-width2+350,height2},
        {-width2+400,-height2},{-width2+400,height2},

        
        {-width2+450,-height2},{-width2+450,height2},
        {-width2+500,-height2},{-width2+500,height2},
        {-width2+550,-height2},{-width2+550,height2},
        {-width2+600,-height2},{-width2+600,height2},

        {-width2+650,-height2},{-width2+650,height2},
        {-width2+700,-height2},{-width2+700,height2},

        {-width2,height2-50},{width2,height2-50},
        {-width2,height2-100},{width2,height2-100},
        {-width2,height2-150},{width2,height2-150},
        {-width2,height2-200},{width2,height2-200},
        {-width2,height2-250},{width2,height2-250},
        {-width2,height2-300},{width2,height2-300},
        {-width2,height2-350},{width2,height2-350},
        {-width2,height2-400},{width2,height2-400},
        {-width2,height2-450},{width2,height2-450},
        {-width2,height2-500},{width2,height2-500},
        {-width2,height2-550},{width2,height2-550},


        {-width2,-height2,-redz*1},{width2,-height2,-redz*1},{width2,height2,-redz*1},{-width2,height2,-redz*1},--outline2
        {-width2,-height2,-redz*2},{width2,-height2,-redz*2},{width2,height2,-redz*2},{-width2,height2,-redz*2},--outline3
        {-width2,-height2,-redz*3},{width2,-height2,-redz*3},{width2,height2,-redz*3},{-width2,height2,-redz*3},--outline4
        {-width2,-height2,-redz*4},{width2,-height2,-redz*4},{width2,height2,-redz*4},{-width2,height2,-redz*4},--outline5
        {-width2,-height2,-redz*5},{width2,-height2,-redz*5},{width2,height2,-redz*5},{-width2,height2,-redz*5},--outline6
        {-width2,-height2,-redz*6},{width2,-height2,-redz*6},{width2,height2,-redz*6},{-width2,height2,-redz*6},--outline7
        {-width2,-height2,-redz*7},{width2,-height2,-redz*7},{width2,height2,-redz*7},{-width2,height2,-redz*7},--outline8
        {-width2,-height2,-redz*8},{width2,-height2,-redz*8},{width2,height2,-redz*8},{-width2,height2,-redz*8},--outline9

        {-width2+150,height2-150},{-width2+200,height2-150},{-width2+200,height2-200},{-width2+150,height2-200},
        {-width2+150,height2-150,250},{-width2+200,height2-150,250},{-width2+200,height2-200,250},{-width2+150,height2-200,250},
        {-width2+200,height2-200,1},{-width2+250,height2-200,1},{-width2+250,height2-250,1},{-width2+200,height2-250,1},
        {-width2+200,height2-200,115},{-width2+250,height2-200,115},{-width2+250,height2-250,115},{-width2+200,height2-250,115},

        {width2-150,height2-150},{width2-200,height2-150},{width2-200,height2-200},{width2-150,height2-200},
        {width2-150,height2-150,250},{width2-200,height2-150,250},{width2-200,height2-200,250},{width2-150,height2-200,250},
        {width2-200,height2-200,1},{width2-250,height2-200,1},{width2-250,height2-250,1},{width2-200,height2-250,1},
        {width2-200,height2-200,115},{width2-250,height2-200,115},{width2-250,height2-250,115},{width2-200,height2-250,115},

        {width2-150,-height2+150},{width2-200,-height2+150},{width2-200,-height2+200},{width2-150,-height2+200},
        {width2-150,-height2+150,250},{width2-200,-height2+150,250},{width2-200,-height2+200,250},{width2-150,-height2+200,250},
        {width2-200,-height2+200,1},{width2-250,-height2+200,1},{width2-250,-height2+250,1},{width2-200,-height2+250,1},
        {width2-200,-height2+200,115},{width2-250,-height2+200,115},{width2-250,-height2+250,115},{width2-200,-height2+250,115},

        {-width2+150,-height2+150},{-width2+200,-height2+150},{-width2+200,-height2+200},{-width2+150,-height2+200},
        {-width2+150,-height2+150,250},{-width2+200,-height2+150,250},{-width2+200,-height2+200,250},{-width2+150,-height2+200,250},
        {-width2+200,-height2+200,1},{-width2+250,-height2+200,1},{-width2+250,-height2+250,1},{-width2+200,-height2+250,1},
        {-width2+200,-height2+200,115},{-width2+250,-height2+200,115},{-width2+250,-height2+250,115},{-width2+200,-height2+250,115},
        },
        segments = {{0,1,2,3,0},--outline
        {4,5},{4,5},{4,5},{4,5},
        {6,7},{6,7},{6,7},{6,7},
        {8,9},{8,9},
        {10,11}, {10,11},

        {12,13},{14,15},{16,17},{18,19},

        {20,21},
        {22,23},
        {24,25},{24,25},
        {26,27},{26,27},
        {28,29},{28,29},{28,29},{28,29},
        {30,31},{31,30},{30,31},{31,30},

        {32,33},{32,33},{32,33},{32,33},
        {34,35},{34,35},{34,35},{34,35},

        {36,37},{36,37},
        {38,39},{38,39},
        {40,41},
        {42,43},{44,45},
        {46,47},{46,47},
        {48,49},{48,49},
        
        {50,51},{50,51},{50,51},{50,51},
        {52,53},{52,53},{52,53},{52,53},


        {54,55,56,57,54},
        {58,59,60,61,58},
        {62,63,64,65,62},
        {66,67,68,69,66},
        {70,71,72,73,70},
        {74,75,76,77,74},
        {78,79,80,81,78},
        {82,83,84,85,82},

        {86,87,88,89,86},
        {90,91,92,93,90},
        {86,90},{87,91},{88,92},{89,93},
        {94,95,96,97,94},
        {98,99,100,101,98},
        {94,98},{95,99},{96,100},{97,101},

        {102,103,104,105,102},
        {106,107,108,109,106},
        {102,106},{103,107},{104,108},{105,109},
        {110,111,112,113,110},
        {114,115,116,117,114},
        {110,114},{111,115},{112,116},{113,117},

        {118,119,120,121,118},
        {122,123,124,125,122},
        {118,122},{119,123},{120,124},{121,125},
        {126,127,128,129,126},
        {130,131,132,133,130},
        {126,130},{127,131},{128,132},{129,133},

        {134,135,136,137,134},
        {138,139,140,141,138},
        {134,138},{135,139},{136,140},{137,141},
        {142,143,144,145,142},
        {146,147,148,149,146},
        {142,146},{143,147},{144,148},{145,149},
        },
        colors = {0xff00ffff,0xff00ffff,0xff00ffff,0xff00ffff,--outline
        0xff00ff20,0xff00ff20,0xff00ff20,0xff00ff20,
        0xff00ff20,0xff00ff20,0xff00ff20,0xff00ff20,

        0xff00ff20,0xff00ff20,0xff00ff20,0xff00ff20,
        0xff00ff20,0xff00ff20,0xff00ff20,0xff00ff20,

        0xff00ff20,0xff00ff20,0xff00ff20,0xff00ff20,
        0xff00ff20,0xff00ff20,0xff00ff20,0xff00ff20,

        0xff00ff20,0xff00ff20,0xff00ff20,0xff00ff20,

        0xff00ff20,0xff00ff20,0xff00ff20,0xff00ff20,
        0xff00ff20,0xff00ff20,0xff00ff20,0xff00ff20,
        0xff00ff20,0xff00ff20,0xff00ff20,0xff00ff20,
        0xff00ff20,0xff00ff20,0xff00ff20,0xff00ff20,
        0xff00ff20,0xff00ff20,0xff00ff20,0xff00ff20,
        0xff00ff20,0xff00ff20,


        0xff00ff90,0xff00ff90,0xff00ff90,0xff00ff90,
        0xff00ff80,0xff00ff80,0xff00ff80,0xff00ff80,
        0xff00ff70,0xff00ff70,0xff00ff70,0xff00ff70,
        0xff00ff60,0xff00ff60,0xff00ff60,0xff00ff60,
        0xff00ff50,0xff00ff50,0xff00ff50,0xff00ff50,
        0xff00ff40,0xff00ff40,0xff00ff40,0xff00ff40,
        0xff00ff30,0xff00ff30,0xff00ff30,0xff00ff30,
        0xff00ff20,0xff00ff20,0xff00ff20,0xff00ff20,


        0xff00ff50,0xff00ff50,0xff00ff50,0xff00ff50,
        0xff00ffff,0xff00ffff,0xff00ffff,0xff00ffff,
        0xff00ff35,0xff00ff35,0xff00ff35,0xff00ff35,
        0xff00ff95,0xff00ff95,0xff00ff95,0xff00ff95,

        0xff00ff50,0xff00ff50,0xff00ff50,0xff00ff50,
        0xff00ffff,0xff00ffff,0xff00ffff,0xff00ffff,
        0xff00ff35,0xff00ff35,0xff00ff35,0xff00ff35,
        0xff00ff95,0xff00ff95,0xff00ff95,0xff00ff95,

        0xff00ff50,0xff00ff50,0xff00ff50,0xff00ff50,
        0xff00ffff,0xff00ffff,0xff00ffff,0xff00ffff,
        0xff00ff35,0xff00ff35,0xff00ff35,0xff00ff35,
        0xff00ff95,0xff00ff95,0xff00ff95,0xff00ff95,

        0xff00ff50,0xff00ff50,0xff00ff50,0xff00ff50,
        0xff00ffff,0xff00ffff,0xff00ffff,0xff00ffff,
        0xff00ff35,0xff00ff35,0xff00ff35,0xff00ff35,
        0xff00ff95,0xff00ff95,0xff00ff95,0xff00ff95,
        }
    },
    {--yellow theme
        vertexes = {{-width2,-height2},{width2,-height2},{width2,height2},{-width2,height2},--outline
        {-width2+100, -height2},{-width2, -height2+100},--LD
        {width2-100, -height2},{width2, -height2+100},--RD
        {-width2+100, height2},{-width2, height2-100},--LU
        {width2-100, height2},{width2, height2-100},--RU

        {0,0,235},--center point

        {-width2+191,-height2+100,115},{width2-191,-height2+100,115},--Co1: LD - RD
        {-width2+283,-height2+200,185},{width2-283,-height2+200,185},--Co2: LD - RD

        {-width2+191,height2-100,115},{width2-191,height2-100,115},--Co3: LU - RU
        {-width2+283,height2-200,185},{width2-283,height2-200,185},--Co4: LU - RU
        
        {-width2+115, -height2+160,115},{-width2+115, height2-160,115},--Co5: LD - LU
        {-width2+230, -height2+222,175},{-width2+230, height2-222,175},--Co6: LD - LU

        {width2-115, -height2+160,115},{width2-115, height2-160,115},--Co7: RD - RU
        {width2-230, -height2+222,175},{width2-230, height2-222,175},--Co8: RD - RU

        {-width2-75,-height2-75,-50},{width2+75,-height2-75,-50},{width2+75,height2+75,-50},{-width2-75,height2+75,-50},--outline2
        {-width2-75*2,-height2-75*2,-100},{width2+75*2,-height2-75*2,-100},{width2+75*2,height2+75*2,-100},{-width2-75*2,height2+75*2,-100},--outline3
        {-width2-75*3,-height2-75*3,-150},{width2+75*3,-height2-75*3,-150},{width2+75*3,height2+75*3,-150},{-width2-75*3,height2+75*3,-150},--outline4
        },
        segments = {{0,1,2,3,0},--outline
        {4,5},{6,7},{8,9},{10,11},--LD,RD,LU,RU

        {13,14},{15,16},--Co1,Co2
        {17,18},{19,20},--Co3,Co4

        {21,22},{23,24},--Co5,Co6
        {25,26},{27,28},--Co7,Co8

        {4,13},{13,15},{15,12},--DL connection
        {6,14},{14,16},{16,12},--DR connection

        {5,21},{21,23},{23,12},--LD connection
        {9,22},{22,24},{24,12},--LU connection

        {8,17},{17,19},{19,12},--UR connection
        {10,18},{18,20},{20,12},--UL connection

        {11,26},{26,28},{28,12},--RU connection
        {7,25},{25,27},{27,12},--RD connection


        {29,30,31,32,29},
        {33,34,35,36,33},
        {37,38,39,40,37},
        },
        colors = {0xffff00ff,0xffff00ff,0xffff00ff,0xffff00ff,--outline
        0xffff00ff,0xffff00ff, 0xffff00ff,0xffff00ff, 0xffff00ff,0xffff00ff, 0xffff00ff,0xffff00ff,

        0xffff0025,--center point 

        0xffff0080,0xffff0080,0xffff0040,0xffff0040,
        0xffff0080,0xffff0080,0xffff0040,0xffff0040,
        0xffff0080,0xffff0080,0xffff0040,0xffff0040,
        0xffff0080,0xffff0080,0xffff0040,0xffff0040,

        0xffff0070,0xffff0070,0xffff0070,0xffff0070,--outline2
        0xffff0045,0xffff0045,0xffff0045,0xffff0045,--outline3
        0xffff0015,0xffff0015,0xffff0015,0xffff0015,--outline3
        }
    },
    {--cyan theme
        vertexes = {{-width2,-height2},{width2,-height2},{width2,height2},{-width2,height2},--outline
        {-50,390},{50,300},{180,360},{260,300},{410, 380},--half top (right)
        {450, 200},{375,120},{490,40},{375,-40},{450,-150},{375,-210},{470,-350},--right
        {300,-390},{200,-300},{110,-360},{20,-300},{-70, -380},{-160,-300},{-250,-360},{-300,-300},{-425,-375}, --bottom
        {-460, 240},{-375,160},{-480,90},{-375,0},{-450,-110},{-375,-170},{-450,-260},--right
        {-430,380},{-280,300},{-200,360},{-130,300},--half top (left)

        {-width2-z+BIG,-height2-z+BIG,Z},{width2+z-BIG,-height2-z+BIG,Z},{width2+z-BIG,height2+z-BIG,Z},{-width2-z+BIG,height2+z-BIG,Z},--outline        
        {-50,390+z,Z},{50,300+z,Z},{180,360+z,Z},{260,300+z,Z},{410, 380+z,Z},--half top (right)
        {450+z, 200,Z},{375+z,120,Z},{490+z,40,Z},{375+z,-40,Z},{450+z,-150,Z},{375+z,-210,Z},{470+z,-350,Z},--right
        {300,-390-z,Z},{200,-300-z,Z},{110,-360-z,Z},{20,-300-z,Z},{-70, -380-z,Z},{-160,-300-z,Z},{-250,-360-z,Z},{-300,-300-z,Z},{-425,-375-z,Z}, --bottom
        {-460-z, 240,Z},{-375-z,160,Z},{-480-z,90,Z},{-375-z,0,Z},{-450-z,-110,Z},{-375-z,-170,Z},{-450-z,-260,Z},--right
        {-430,380+z,Z},{-280,300+z,Z},{-200,360+z,Z},{-130,300+z,Z},--half top (left)

        {-width2-z*2+BIG,-height2-z*2+BIG,Z*2},{width2+z*2-BIG,-height2-z*2+BIG,Z*2},{width2+z*2-BIG,height2+z*2-BIG,Z*2},{-width2-z*2+BIG,height2+z*2-BIG,Z*2},--outline        
        {-50,390+z*2,Z*2},{50,300+z*2,Z*2},{180,360+z*2,Z*2},{260,300+z*2,Z*2},{410, 380+z*2,Z*2},--half top (right)
        {450+z*2, 200,Z*2},{375+z*2,120,Z*2},{490+z*2,40,Z*2},{375+z*2,-40,Z*2},{450+z*2,-150,Z*2},{375+z*2,-210,Z*2},{470+z*2,-350,Z*2},--right
        {300,-390-z*2,Z*2},{200,-300-z*2,Z*2},{110,-360-z*2,Z*2},{20,-300-z*2,Z*2},{-70, -380-z*2,Z*2},{-160,-300-z*2,Z*2},{-250,-360-z*2,Z*2},{-300,-300-z*2,Z*2},{-425,-375-z*2,Z*2}, --bottom
        {-460-z*2, 240,Z*2},{-375-z*2,160,Z*2},{-480-z*2,90,Z*2},{-375-z*2,0,Z*2},{-450-z*2,-110,Z*2},{-375-z*2,-170,Z*2},{-450-z*2,-260,Z*2},--right
        {-430,380+z*2,Z*2},{-280,300+z*2,Z*2},{-200,360+z*2,Z*2},{-130,300+z*2,Z*2},--half top (left)

        {-width2-z*3+BIG,-height2-z*3+BIG,Z*3},{width2+z*3-BIG,-height2-z*3+BIG,Z*3},{width2+z*3-BIG,height2+z*3-BIG,Z*3},{-width2-z*3+BIG,height2+z*3-BIG,Z*3},--outline        
        {-50,390+z*3,Z*3},{50,300+z*3,Z*3},{180,360+z*3,Z*3},{260,300+z*3,Z*3},{410, 380+z*3,Z*3},--half top (right)
        {450+z*3, 200,Z*3},{375+z*3,120,Z*3},{490+z*3,40,Z*3},{375+z*3,-40,Z*3},{450+z*3,-150,Z*3},{375+z*3,-210,Z*3},{470+z*3,-350,Z*3},--right
        {300,-390-z*3,Z*3},{200,-300-z*3,Z*3},{110,-360-z*3,Z*3},{20,-300-z*3,Z*3},{-70, -380-z*3,Z*3},{-160,-300-z*3,Z*3},{-250,-360-z*3,Z*3},{-300,-300-z*3,Z*3},{-425,-375-z*3,Z*3}, --bottom
        {-460-z*3, 240,Z*3},{-375-z*3,160,Z*3},{-480-z*3,90,Z*3},{-375-z*3,0,Z*3},{-450-z*3,-110,Z*3},{-375-z*3,-170,Z*3},{-450-z*3,-260,Z*3},--right
        {-430,380+z*3,Z*3},{-280,300+z*3,Z*3},{-200,360+z*3,Z*3},{-130,300+z*3,Z*3},--half top (left)

        {-width2-z*4+BIG,-height2-z*4+BIG,Z*4},{width2+z*4-BIG,-height2-z*4+BIG,Z*4},{width2+z*4-BIG,height2+z*4-BIG,Z*4},{-width2-z*4+BIG,height2+z*4-BIG,Z*4},--outline        
        {-50,390+z*4,Z*4},{50,300+z*4,Z*4},{180,360+z*4,Z*4},{260,300+z*4,Z*4},{410, 380+z*4,Z*4},--half top (right)
        {450+z*4, 200,Z*4},{375+z*4,120,Z*4},{490+z*4,40,Z*4},{375+z*4,-40,Z*4},{450+z*4,-150,Z*4},{375+z*4,-210,Z*4},{470+z*4,-350,Z*4},--right
        {300,-390-z*4,Z*4},{200,-300-z*4,Z*4},{110,-360-z*4,Z*4},{20,-300-z*4,Z*4},{-70, -380-z*4,Z*4},{-160,-300-z*4,Z*4},{-250,-360-z*4,Z*4},{-300,-300-z*4,Z*4},{-425,-375-z*4,Z*4}, --bottom
        {-460-z*4, 240,Z*4},{-375-z*4,160,Z*4},{-480-z*4,90,Z*4},{-375-z*4,0,Z*4},{-450-z*4,-110,Z*4},{-375-z*4,-170,Z*4},{-450-z*4,-260,Z*4},--right
        {-430,380+z*4,Z*4},{-280,300+z*4,Z*4},{-200,360+z*4,Z*4},{-130,300+z*4,Z*4},--half top (left)

        {-width2-z*5+BIG,-height2-z*5+BIG,Z*5},{width2+z*5-BIG,-height2-z*5+BIG,Z*5},{width2+z*5-BIG,height2+z*5-BIG,Z*5},{-width2-z*5+BIG,height2+z*5-BIG,Z*5},--outline        
        {-50,390+z*5,Z*5},{50,300+z*5,Z*5},{180,360+z*5,Z*5},{260,300+z*5,Z*5},{410, 380+z*5,Z*5},--half top (right)
        {450+z*5, 200,Z*5},{375+z*5,120,Z*5},{490+z*5,40,Z*5},{375+z*5,-40,Z*5},{450+z*5,-150,Z*5},{375+z*5,-210,Z*5},{470+z*5,-350,Z*5},--right
        {300,-390-z*5,Z*5},{200,-300-z*5,Z*5},{110,-360-z*5,Z*5},{20,-300-z*5,Z*5},{-70, -380-z*5,Z*5},{-160,-300-z*5,Z*5},{-250,-360-z*5,Z*5},{-300,-300-z*5,Z*5},{-425,-375-z*5,Z*5}, --bottom
        {-460-z*5, 240,Z*5},{-375-z*5,160,Z*5},{-480-z*5,90,Z*5},{-375-z*5,0,Z*5},{-450-z*5,-110,Z*5},{-375-z*5,-170,Z*5},{-450-z*5,-260,Z*5},--right
        {-430,380+z*5,Z*5},{-280,300+z*5,Z*5},{-200,360+z*5,Z*5},{-130,300+z*5,Z*5},--half top (left)



        {-width2-z*6+BIG,-height2-z*6+BIG,Z*6},{width2+z*6-BIG,-height2-z*6+BIG,Z*6},{width2+z*6-BIG,height2+z*6-BIG,Z*6},{-width2-z*6+BIG,height2+z*6-BIG,Z*6},--outline        
        {-50,390+z*6,Z*6},{50,300+z*6,Z*6},{180,360+z*6,Z*6},{260,300+z*6,Z*6},{410, 380+z*6,Z*6},--half top (right)
        {450+z*6, 200,Z*6},{375+z*6,120,Z*6},{490+z*6,40,Z*6},{375+z*6,-40,Z*6},{450+z*6,-150,Z*6},{375+z*6,-210,Z*6},{470+z*6,-350,Z*6},--right
        {300,-390-z*6,Z*6},{200,-300-z*6,Z*6},{110,-360-z*6,Z*6},{20,-300-z*6,Z*6},{-70, -380-z*6,Z*6},{-160,-300-z*6,Z*6},{-250,-360-z*6,Z*6},{-300,-300-z*6,Z*6},{-425,-375-z*6,Z*6}, --bottom
        {-460-z*6, 240,Z*6},{-375-z*6,160,Z*6},{-480-z*6,90,Z*6},{-375-z*6,0,Z*6},{-450-z*6,-110,Z*6},{-375-z*6,-170,Z*6},{-450-z*6,-260,Z*6},--right
        {-430,380+z*6,Z*6},{-280,300+z*6,Z*6},{-200,360+z*6,Z*6},{-130,300+z*6,Z*6},--half top (left)

        {-width2-z*8+BIG,-height2-z*8+BIG,Z*6},{width2+z*8-BIG,-height2-z*8+BIG,Z*6},{width2+z*8-BIG,height2+z*8-BIG,Z*6},{-width2-z*8+BIG,height2+z*8-BIG,Z*6},--outline        
        {-50,390+z*8,Z*6},{50,300+z*8,Z*6},{180,360+z*8,Z*6},{260,300+z*8,Z*6},{410, 380+z*8,Z*6},--half top (right)
        {450+z*8, 200,Z*6},{375+z*8,120,Z*6},{490+z*8,40,Z*6},{375+z*8,-40,Z*6},{450+z*8,-150,Z*6},{375+z*8,-210,Z*6},{470+z*8,-350,Z*6},--right
        {300,-390-z*8,Z*6},{200,-300-z*8,Z*6},{110,-360-z*8,Z*6},{20,-300-z*8,Z*6},{-70, -380-z*8,Z*6},{-160,-300-z*8,Z*6},{-250,-360-z*8,Z*6},{-300,-300-z*8,Z*6},{-425,-375-z*8,Z*6}, --bottom
        {-460-z*8, 240,Z*6},{-375-z*8,160,Z*6},{-480-z*8,90,Z*6},{-375-z*8,0,Z*6},{-450-z*8,-110,Z*6},{-375-z*8,-170,Z*6},{-450-z*8,-260,Z*6},--right
        {-430,380+z*8,Z*6},{-280,300+z*8,Z*6},{-200,360+z*8,Z*6},{-130,300+z*8,Z*6},--half top (left)



        {-width2-z*10+BIG,-height2-z*10+BIG,Z*5},{width2+z*10-BIG,-height2-z*10+BIG,Z*5},{width2+z*10-BIG,height2+z*10-BIG,Z*5},{-width2-z*10+BIG,height2+z*10-BIG,Z*5},--outline        
        {-50,390+z*10,Z*5},{50,300+z*10,Z*5},{180,360+z*10,Z*5},{260,300+z*10,Z*5},{410, 380+z*10,Z*5},--half top (right)
        {450+z*10, 200,Z*5},{375+z*10,120,Z*5},{490+z*10,40,Z*5},{375+z*10,-40,Z*5},{450+z*10,-150,Z*5},{375+z*10,-210,Z*5},{470+z*10,-350,Z*5},--right
        {300,-390-z*10,Z*5},{200,-300-z*10,Z*5},{110,-360-z*10,Z*5},{20,-300-z*10,Z*5},{-70, -380-z*10,Z*5},{-160,-300-z*10,Z*5},{-250,-360-z*10,Z*5},{-300,-300-z*10,Z*5},{-425,-375-z*10,Z*5}, --bottom
        {-460-z*10, 240,Z*5},{-375-z*10,160,Z*5},{-480-z*10,90,Z*5},{-375-z*10,0,Z*5},{-450-z*10,-110,Z*5},{-375-z*10,-170,Z*5},{-450-z*10,-260,Z*5},--right
        {-430,380+z*10,Z*5},{-280,300+z*10,Z*5},{-200,360+z*10,Z*5},{-130,300+z*10,Z*5},--half top (left)
        
        {-width2-z*12+BIG,-height2-z*12+BIG,Z*4},{width2+z*12-BIG,-height2-z*12+BIG,Z*4},{width2+z*12-BIG,height2+z*12-BIG,Z*4},{-width2-z*12+BIG,height2+z*12-BIG,Z*4},--outline        
        {-50,390+z*12,Z*4},{50,300+z*12,Z*4},{180,360+z*12,Z*4},{260,300+z*12,Z*4},{410, 380+z*12,Z*4},--half top (right)
        {450+z*12, 200,Z*4},{375+z*12,120,Z*4},{490+z*12,40,Z*4},{375+z*12,-40,Z*4},{450+z*12,-150,Z*4},{375+z*12,-210,Z*4},{470+z*12,-350,Z*4},--right
        {300,-390-z*12,Z*4},{200,-300-z*12,Z*4},{110,-360-z*12,Z*4},{20,-300-z*12,Z*4},{-70, -380-z*12,Z*4},{-160,-300-z*12,Z*4},{-250,-360-z*12,Z*4},{-300,-300-z*12,Z*4},{-425,-375-z*12,Z*4}, --bottom
        {-460-z*12, 240,Z*4},{-375-z*12,160,Z*4},{-480-z*12,90,Z*4},{-375-z*12,0,Z*4},{-450-z*12,-110,Z*4},{-375-z*12,-170,Z*4},{-450-z*12,-260,Z*4},--right
        {-430,380+z*12,Z*4},{-280,300+z*12,Z*4},{-200,360+z*12,Z*4},{-130,300+z*12,Z*4},--half top (left)

        {-width2-z*14+BIG,-height2-z*14+BIG,Z*3},{width2+z*14-BIG,-height2-z*14+BIG,Z*3},{width2+z*14-BIG,height2+z*14-BIG,Z*3},{-width2-z*14+BIG,height2+z*14-BIG,Z*3},--outline        
        {-50,390+z*14,Z*3},{50,300+z*14,Z*3},{180,360+z*14,Z*3},{260,300+z*14,Z*3},{410, 380+z*14,Z*3},--half top (right)
        {450+z*14, 200,Z*3},{375+z*14,120,Z*3},{490+z*14,40,Z*3},{375+z*14,-40,Z*3},{450+z*14,-150,Z*3},{375+z*14,-210,Z*3},{470+z*14,-350,Z*3},--right
        {300,-390-z*14,Z*3},{200,-300-z*14,Z*3},{110,-360-z*14,Z*3},{20,-300-z*14,Z*3},{-70, -380-z*14,Z*3},{-160,-300-z*14,Z*3},{-250,-360-z*14,Z*3},{-300,-300-z*14,Z*3},{-425,-375-z*14,Z*3}, --bottom
        {-460-z*14, 240,Z*3},{-375-z*14,160,Z*3},{-480-z*14,90,Z*3},{-375-z*14,0,Z*3},{-450-z*14,-110,Z*3},{-375-z*14,-170,Z*3},{-450-z*14,-260,Z*3},--right
        {-430,380+z*14,Z*3},{-280,300+z*14,Z*3},{-200,360+z*14,Z*3},{-130,300+z*14,Z*3},--half top (left)

        {-width2-z*16+BIG,-height2-z*16+BIG,Z*2},{width2+z*16-BIG,-height2-z*16+BIG,Z*2},{width2+z*16-BIG,height2+z*16-BIG,Z*2},{-width2-z*16+BIG,height2+z*16-BIG,Z*2},--outline        
        {-50,390+z*16,Z*2},{50,300+z*16,Z*2},{180,360+z*16,Z*2},{260,300+z*16,Z*2},{410, 380+z*16,Z*2},--half top (right)
        {450+z*16, 200,Z*2},{375+z*16,120,Z*2},{490+z*16,40,Z*2},{375+z*16,-40,Z*2},{450+z*16,-150,Z*2},{375+z*16,-210,Z*2},{470+z*16,-350,Z*2},--right
        {300,-390-z*16,Z*2},{200,-300-z*16,Z*2},{110,-360-z*16,Z*2},{20,-300-z*16,Z*2},{-70, -380-z*16,Z*2},{-160,-300-z*16,Z*2},{-250,-360-z*16,Z*2},{-300,-300-z*16,Z*2},{-425,-375-z*16,Z*2}, --bottom
        {-460-z*16, 240,Z*2},{-375-z*16,160,Z*2},{-480-z*16,90,Z*2},{-375-z*16,0,Z*2},{-450-z*16,-110,Z*2},{-375-z*16,-170,Z*2},{-450-z*16,-260,Z*2},--right
        {-430,380+z*16,Z*2},{-280,300+z*16,Z*2},{-200,360+z*16,Z*2},{-130,300+z*16,Z*2},--half top (left)
        },
        segments = {{0,1,2,3,0},--outline
        {
        4,5,6,7,8,2,--half top (right)
        9,10,11,12,13,14,15,1,--right
        16,17,18,19,20,21,22,23,24,0,--bottom
        31,30,29,28,27,26,25,3,--left
        32,33,34,35,4,--half top (left)
        },
        {26,17},{30,33},{23,7},{19,12},
        {--36,37,38,39,40
        40,41,42,43,44,38,
        45,46,47,48,49,50,51,37,
        52,53,54,55,56,57,58,59,60,36,
        67,66,65,64,63,62,61,39,
        68,69,70,71,40
        },
        {43,53},{71,62},{64,57},
        {--72,73,74,75
        76,77,78,79,80,74,
        81,82,83,84,85,86,87,73,
        88,89,90,91,92,93,94,95,96,72,
        103,102,101,100,99,98,97,75,
        104,105,106,107,76,
        },
        {98,84},
        {--108,109,110,111
        112,113,114,115,116,110,
        117,118,119,120,121,122,123,109,
        124,125,126,127,128,129,130,131,132,108,
        139,138,137,136,135,134,133,111,
        140,141,142,143,112,
        },
        {131,116},
        {--144,145,146,147
        148,149,150,151,152,146,
        153,154,155,156,157,158,159,145,
        160,161,162,163,164,165,166,167,168,144,
        175,174,173,172,171,170,169,147,
        176,177,178,179,148, 
        },
        {145,147},
        {--180,181,182,183
        184,185,186,187,188,182,
        189,190,191,192,193,194,195,181,
        196,197,198,199,200,201,202,203,204,180,
        211,210,209,208,207,206,205,183,
        212,213,214,215,184,       
        },
        {208,199},{185,197},
        {--216,217,218,219
        220,221,222,223,224,218,
        225,226,227,228,229,230,231,217,
        232,233,234,235,236,237,238,239,240,216,
        247,246,245,244,243,242,241,219,
        248,249,250,251,220,
        },
        {--252,253,254,255
        256,257,258,259,260,254,
        261,262,263,264,265,266,267,253,
        268,269,270,271,272,273,274,275,276,252,
        283,282,281,280,279,278,277,255,
        284,285,286,287,256,
        },
        {--288,289,290,291
        292,293,294,295,296,290,
        297,298,299,300,301,302,303,289,
        304,305,306,307,308,309,310,311,312,288,
        319,318,317,316,315,314,313,291,
        320,321,322,323,292
        },
        {--324,325,326,327
        328,329,330,331,332,326,
        333,334,335,336,337,338,339,325,
        340,341,342,343,344,345,346,347,348,324,
        355,354,353,352,351,350,349,327,
        356,357,358,359,328,
        },
        {--360,361,362,363
        364,365,366,367,368,362,
        369,370,371,372,373,374,375,361,
        376,377,378,379,380,381,382,383,384,360,
        391,390,389,388,387,386,385,363,
        392,393,394,395,364,
        },
        {--396,397,398,399
        400,401,402,403,404,398,
        405,406,407,408,409,410,411,397,
        412,413,414,415,416,417,418,419,420,396,
        427,426,425,424,423,422,421,399,
        428,429,430,431,400,
        },
        },
        colors = {0x00ffff40,0x00ffff40,0x00ffff40,0x00ffff40,--outline
        0x00ffff40,0x00ffff40,0x00ffff40,0x00ffff40,0x00ffff40,--half top (right)
        0x00ffff40,0x00ffff40,0x00ffff40,0x00ffff40,0x00ffff40,0x00ffff40,0x00ffff40,--right
        0x00ffff40,0x00ffff40,0x00ffff40,0x00ffff40,0x00ffff40,0x00ffff40,0x00ffff40,0x00ffff40,0x00ffff40,--bottom
        0x00ffff40,0x00ffff40,0x00ffff40,0x00ffff40,0x00ffff40,0x00ffff40,0x00ffff40,--left
        0x00ffff40,0x00ffff40,0x00ffff40,0x00ffff40,--half top (left)
        
        0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,--outline
        0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,--half top (right)
        0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,--right
        0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,--bottom
        0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,--left
        0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,--half top (left)

        0x00ffff60,0x00ffff60,0x00ffff60,0x00ffff60,--outline
        0x00ffff60,0x00ffff60,0x00ffff60,0x00ffff60,0x00ffff60,--half top (right)
        0x00ffff60,0x00ffff60,0x00ffff60,0x00ffff60,0x00ffff60,0x00ffff60,0x00ffff60,--right
        0x00ffff60,0x00ffff60,0x00ffff60,0x00ffff60,0x00ffff60,0x00ffff60,0x00ffff60,0x00ffff60,0x00ffff60,--bottom
        0x00ffff60,0x00ffff60,0x00ffff60,0x00ffff60,0x00ffff60,0x00ffff60,0x00ffff60,--left
        0x00ffff60,0x00ffff60,0x00ffff60,0x00ffff60,--half top (left)

        0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,--outline
        0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,--half top (right)
        0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,--right
        0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,--bottom
        0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,--left
        0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,--half top (left)

        0x00ffff80,0x00ffff80,0x00ffff80,0x00ffff80,--outline
        0x00ffff80,0x00ffff80,0x00ffff80,0x00ffff80,0x00ffff80,--half top (right)
        0x00ffff80,0x00ffff80,0x00ffff80,0x00ffff80,0x00ffff80,0x00ffff80,0x00ffff80,--right
        0x00ffff80,0x00ffff80,0x00ffff80,0x00ffff80,0x00ffff80,0x00ffff80,0x00ffff80,0x00ffff80,0x00ffff80,--bottom
        0x00ffff80,0x00ffff80,0x00ffff80,0x00ffff80,0x00ffff80,0x00ffff80,0x00ffff80,--left
        0x00ffff80,0x00ffff80,0x00ffff80,0x00ffff80,--half top (left)

        0x00ffff95,0x00ffff95,0x00ffff95,0x00ffff95,--outline
        0x00ffff95,0x00ffff95,0x00ffff95,0x00ffff95,0x00ffff95,--half top (right)
        0x00ffff95,0x00ffff95,0x00ffff95,0x00ffff95,0x00ffff95,0x00ffff95,0x00ffff95,--right
        0x00ffff95,0x00ffff95,0x00ffff95,0x00ffff95,0x00ffff95,0x00ffff95,0x00ffff95,0x00ffff95,0x00ffff95,--bottom
        0x00ffff95,0x00ffff95,0x00ffff95,0x00ffff95,0x00ffff95,0x00ffff95,0x00ffff95,--left
        0x00ffff95,0x00ffff95,0x00ffff95,0x00ffff95,--half top (left)



        0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,--outline
        0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,--half top (right)
        0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,--right
        0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,--bottom
        0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,--left
        0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,--half top (left)

        0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,--outline
        0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,--half top (right)
        0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,--right
        0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,--bottom
        0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,--left
        0x00ffffff,0x00ffffff,0x00ffffff,0x00ffffff,--half top (left)



        0x00ffff90,0x00ffff90,0x00ffff90,0x00ffff90,--outline
        0x00ffff90,0x00ffff90,0x00ffff90,0x00ffff90,0x00ffff90,--half top (right)
        0x00ffff90,0x00ffff90,0x00ffff90,0x00ffff90,0x00ffff90,0x00ffff90,0x00ffff90,--right
        0x00ffff90,0x00ffff90,0x00ffff90,0x00ffff90,0x00ffff90,0x00ffff90,0x00ffff90,0x00ffff90,0x00ffff90,--bottom
        0x00ffff90,0x00ffff90,0x00ffff90,0x00ffff90,0x00ffff90,0x00ffff90,0x00ffff90,--left
        0x00ffff90,0x00ffff90,0x00ffff90,0x00ffff90,--half top (left)

        0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,--outline
        0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,--half top (right)
        0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,--right
        0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,--bottom
        0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,--left
        0x00ffff70,0x00ffff70,0x00ffff70,0x00ffff70,--half top (left)

        0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,--outline
        0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,--half top (right)
        0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,--right
        0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,--bottom
        0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,--left
        0x00ffff50,0x00ffff50,0x00ffff50,0x00ffff50,--half top (left)

        0x00ffff30,0x00ffff30,0x00ffff30,0x00ffff30,--outline
        0x00ffff30,0x00ffff30,0x00ffff30,0x00ffff30,0x00ffff30,--half top (right)
        0x00ffff30,0x00ffff30,0x00ffff30,0x00ffff30,0x00ffff30,0x00ffff30,0x00ffff30,--right
        0x00ffff30,0x00ffff30,0x00ffff30,0x00ffff30,0x00ffff30,0x00ffff30,0x00ffff30,0x00ffff30,0x00ffff30,--bottom
        0x00ffff30,0x00ffff30,0x00ffff30,0x00ffff30,0x00ffff30,0x00ffff30,0x00ffff30,--left
        0x00ffff30,0x00ffff30,0x00ffff30,0x00ffff30,--half top (left)

        }
    },
    {-- blank
        vertexes = {{0,0},{1,0}},
        segments = {{0,1}}
    }
    
}


reset
set term png    #terminal and output file
set output "pie-2011.png"
set size square    #square size
set isosample 50,50    #samples
set parametric    #parametric mode on
set xrange [-1:1]    #x,y,v range
set yrange [-1:1]
set vrange [0:1]
unset border    #no border, tics and colorbox
unset xtics
unset ytics
unset colorbox
set view map    #the view point
set palette defined(0 "red",1 "green",2 "blue",\
    3 "yellow",4 "cyan",5 "brown",6 "greenyellow",\
    7 "gray",8"bisque",9"violet",10"black")
#The color palette
set cbrange [0:10]
set multiplot    #multiplot mode
set urange [0.000000*2*pi:0.050000*2*pi]
set label 1 center "Mobile" at 1.187688,0.356434 rotate   by 0.157080*180/pi
splot cos(u)*v,sin(u)*v,0.000000 w pm3d   notitle
set urange [0.050000*2*pi:1.000000*2*pi]
set label 2 center "NonMobile" at -1.187688,-0.356434 rotate   by 3.298672*180/pi
splot cos(u)*v,sin(u)*v,1.000000 w pm3d   notitle
unset multiplot
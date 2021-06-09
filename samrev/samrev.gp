reset
set pm3d map
set palette gray
set term png
set output "mr.png"
unset xlabel
unset ylabel
set autoscale xfix
set autoscale yfix
set size ratio -1
plot "mr.dat"  u 1:(-$2):3 w image

#--------------------------------------------------------------------------------
reset
set pm3d map corners2color c1
set palette defined (1 'white', 2 'blue', 3 'red',4 'yellow' ,5 'pink')
set term png
set output "cor.png"
unset xlabel
unset ylabel
set autoscale xfix
set autoscale yfix
set size ratio -1
plot "cor.dat"  u 1:(-$2):3 w image

#--------------------------------------------------------------------------------
reset
set pm3d map corners2color c1
set term png
set log cb
unset xlabel
unset ylabel
set autoscale xfix
set autoscale yfix
set size ratio -1
set output "j.png"
plot "j.dat"  u 1:(-$2):3 w image

#--------------------------------------------------------------------------------
reset
unset key
#set size 0.26,0.5
set pm3d map
#set dgrid3d 254,333
set palette gray
unset xtics
unset ytics
unset colorbox
#set xrange [1:254]
#set yrange [1:333]
set term png size 254,333
set output "mr_raw.png"
unset xlabel
unset ylabel
set autoscale xfix
set autoscale yfix
set margins 0,0,0,0
set size ratio -1
unset xtics
unset ytics
set border 0
unset key
plot "mr.dat"  u 1:(-$2):3 w image

#--------------------------------------------------------------------------------
reset
unset key
#set size 0.26,0.5
set pm3d map corners2color c1
#set dgrid3d 254,333
set palette defined (1 'white', 2 'blue', 3 'red',4 'yellow' ,5 'pink')
unset xtics
unset ytics
unset colorbox
#set xrange [1:254]
#set yrange [1:333]
set term png size 254,333
set output "cor_raw.png"
unset xlabel
unset ylabel
set autoscale xfix
set autoscale yfix
set margins 0,0,0,0
set size ratio -1
unset xtics
unset ytics
set border 0
unset key
plot "cor.dat"  u 1:(-$2):3 w image

#--------------------------------------------------------------------------------
reset
unset key
#set size 0.26,0.5
set pm3d map corners2color c1
#set dgrid3d 254,333
unset xtics
unset ytics
unset colorbox
set log cb
#set xrange [1:254]
#set yrange [1:333]
set term png size 254,333
unset xlabel
unset ylabel
set autoscale xfix
set autoscale yfix
set margins 0,0,0,0
set size ratio -1
unset xtics
unset ytics
set border 0
unset key
set output "j_raw.png"
plot "j.dat"  u 1:(-$2):3 w image
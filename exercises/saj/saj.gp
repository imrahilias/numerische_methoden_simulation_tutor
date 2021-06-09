#--------------------------------------------------------------------------------
reset
unset key
set logscale x
set xlabel 'kbT / a.u.'
set ylabel 'flips / pixel / sweep'
set term png
set output "flips.png"
plot 'flips.dat' u 2:($3/254/333) w l

#--------------------------------------------------------------------------------
reset
set term png
#set term png size 25,25
set pm3d map
set output "jj.png"
plot "jj.dat"  u 1:2:3 w image

#--------------------------------------------------------------------------------
reset
set term png
set pm3d map
set output "energy.png"
plot "energy.dat"  u 1:(-$2):3 w image

#--------------------------------------------------------------------------------
reset
set term png
set pm3d map
set output "weighted.png"
plot "energy.dat"  u 1:(-$2):4 w image


#--------------------------------------------------------------------------------
reset
set term png
set pm3d map
set output "pos.png"
plot "pos.dat" u 1:(-$2):3 w image

#--------------------------------------------------------------------------------
reset
unset key
unset xtics
unset ytics
unset colorbox
unset xlabel
unset ylabel
set autoscale xfix
set autoscale yfix
set margins 0,0,0,0
set size ratio -1
unset xtics
unset ytics
set border 0
set palette gray
set term png size 254,333
set pm3d map
set output "mr.png"
plot "mr.dat"  u 1:(-$2):3 w image

#--------------------------------------------------------------------------------
reset
unset key
unset xtics
unset ytics
unset colorbox
unset xlabel
unset ylabel
set autoscale xfix
set autoscale yfix
set margins 0,0,0,0
set size ratio -1
unset xtics
unset ytics
set border 0
set term png size 254,333
set pm3d map corners2color c1
set palette defined (1 'white', 2 'blue', 3 'red',4 'yellow' ,5 'pink')
set output "cor.png"
plot "cor.dat"  u 1:(-$2):3 w image

#--------------------------------------------------------------------------------
reset
unset key
unset xtics
unset ytics
unset colorbox
unset xlabel
unset ylabel
set autoscale xfix
set autoscale yfix
set margins 0,0,0,0
set size ratio -1
unset xtics
unset ytics
set border 0
set term png size 254,333
set pm3d map
set output "pos_raw.png"
plot "pos.dat"  u 1:(-$2):3 w image
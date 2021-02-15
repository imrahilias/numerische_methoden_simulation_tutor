reset
set key
set size square
set term png size 1920,1080
set out 'linreg.png'
set title
#set cbr [1e-5:]
#set xrange [-10:10]
#set xrange [-10:10]
set xlabel 'x'
set ylabel 'y'
p 'lin-reg.txt' u 1:2 w p pt 7 lc 0 ps 2 t 'data', \
'linreg.dat' u 1:2 w l t 'linreg'
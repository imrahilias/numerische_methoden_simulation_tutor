reset
set key
set size square
set term png size 1920,1080
set out 'interpol.png'
set title
#set cbr [1e-5:]
#set xrange [-10:10]
#set xrange [-10:10]
set xlabel 'x'
set ylabel 'y'
p 'int-pol.txt' u 1:2 w p pt 7 lc 0 ps 2 t 'data', \
'poly.dat' u 1:2 w l t 'polynom', \
'int-pol.txt' smooth csplines t 'splines'
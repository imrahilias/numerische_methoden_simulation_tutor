reset
set key
set size square
set term png size 1920,1080
set out 'rawk.png'
set title
#set cbr [1e-5:]
set xlabel 'steps'
set ylabel 'distance'
f(x) = a + b * sqrt(x)
fit f(x) 'rawk.dat' via a,b
p 'rawk.dat', \
f(x)
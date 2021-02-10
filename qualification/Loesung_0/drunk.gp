reset
unset key
set size square
set term png size 1920,1080
set out 'rawk.png'
f(x) = a + b * sqrt(x)
fit f(x) 'mittelwert.txt' via a,b
p 'mittelwert.txt', f(x)
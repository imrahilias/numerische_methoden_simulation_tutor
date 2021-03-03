# precision

ein allgmeines und wichtiges thema in fortran ist precision. real und
vor allem double precision wird allerdings nicht von allen compilern
gleich interpretiert, um sicherzugehn empfiehlt sich die variablen
folgendermaßen zu initialisieren:
"
integer, parameter :: p=selected_real_kind(16)
real(kind=p) :: x
"


# filenames

es ist üblich alle fortran source files mit der endung ".f90" zu
versehen, auch wenn sie mit einem späteren standard geschrieben sind
(zb 2008). die wesentliche unterscheidung ist hier zwischen fortran77
und fortran90.


# shell files

um sich zu ersparen fortran code kompilieren zu müssen, dann
auszuführen und schließlich zu plotten, kann auch alles is ein shell
skript "linreg.sh" zusammengefasst werden:

"
#!/bin/sh
time gfortran -o linreg linreg.f90 &&
time ./linreg &&
time gnuplot linreg.gp
"

die "&&" stellen sicher, dass der folgende befehl nur ausgeführt wird,
wenn der lezte keine fehler ausgibt.  das hier aufgerufene "linreg.gp"
ist ebenfalls ein text file mit gnuplot anwendugen:

"
reset
set key
set size square
set term png size 1920,1080
set out 'linreg.png'
set title
set xlabel 'x'
set ylabel 'y'
f(x) = a * x + b
fit f(x) 'lin-reg.txt' via a,b
p 'lin-reg.txt' u 1:2 w p pt 7 lc 0 ps 2 t 'data', \
'linreg.dat' u 1:2 w l t 'linreg', \
f(x) t 'fit'
"

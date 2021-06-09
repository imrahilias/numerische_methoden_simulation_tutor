.PHONY: all clean

all: 	saj

clean:
	rm energy.dat energy.png flips.dat flips.png jj.dat jj.png pos.dat pos.png saj saj.log

saj: 	saj.f90 saj.gp cor.dat mr.dat
	gfortran -Og -Wall -fimplicit-none -fcheck=all -fbacktrace -o saj saj.f90
	./saj > saj.log
	gnuplot saj.gp




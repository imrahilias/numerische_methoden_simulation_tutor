.PHONY: all clean

all: saj

clean: 
	rm saj j.dat cor.png j.png mr.png cor_raw.png j_raw.png mr_raw.png saj.log

saj: saj.f90 saj.gp cor.dat mr.dat
	gfortran -Og -Wall -fimplicit-none -fcheck=all -fbacktrace -o saj saj.f90
	./saj > saj.log
	gnuplot saj.gp




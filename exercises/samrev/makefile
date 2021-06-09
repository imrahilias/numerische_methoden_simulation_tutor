.PHONY: all clean

all: samrev

clean: 
	rm samrev cor.png j.png mr.png cor_raw.png j_raw.png mr_raw.png samrev.log

samrev: samrev.f90 samrev.gp
	gfortran -Og -Wall -fimplicit-none -fcheck=all -fbacktrace -o samrev samrev.f90
	#./samrev
	./samrev	> samrev.log
	gnuplot samrev.gp




program drunk
implicit none
double precision:: theta = 0d0,  Randy = 0d0, x = 0d0,  y = 0d0
double precision, parameter :: twopi = 6.28318530718
double precision, dimension(0:1000):: entf
integer:: nsteps, nwalks, s, w, k

nsteps=1e3
nwalks=1e5


entf=0 

call random_seed()
do w=1,nwalks
x=0d0
y=0d0
  do s=1,nsteps
    call random_number(Randy)
    theta = twopi * Randy
    x=x+cos(theta)
    y=y+sin(theta)
    entf(s)=entf(s)+sqrt(x**2+y**2)
    end do
end do

open(unit=20, file='mittelwert.txt')
entf=entf/nwalks
do k=0, nsteps
  write(20,*)k,entf(k)
end do
close(20)

end program

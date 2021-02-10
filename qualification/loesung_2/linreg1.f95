program linreg
implicit NONE


double precision, dimension(0:9) :: X=0d0, Y=0d0, XY=0d0, XQ=0d0, YQ=0d0, Yn=0d0
double precision:: sumX = 0d0, sumY = 0d0, sumXQ=0d0, sumYQ = 0d0, sumXY = 0d0, m = 0d0, b= 0d0
integer:: i, n, k, j
integer, parameter :: D=9
integer :: nmax=2000

open(unit=20, file='int-pol.txt')

do j=0,D
    read(20,*) X(j), Y(j)     !speichere in x werte in x und die y werte in die erste spalte der matrix
    print*,j, X(j), Y(j)
    end do

close(20)
do j=0,D
 XQ(j)= X(j)*X(j)
 YQ(j)= Y(j)*Y(j)
 XY(j)= X(j)*Y(j)
end do

do i=0, D
sumX = sumX + X(i)
sumY= sumY + Y(i)
sumXQ= sumXQ + XQ(i)
sumYQ= sumYQ + YQ(i)
sumXY= sumXY + XY(i)
n = n + 1
end do

m = (n*(sumXY)-sumX*sumY)/(n*(sumXQ)-sumX**2)
b = ((sumY*sumXQ)-(sumX-sumXY))/(n*sumXQ-sumX**2)


print*,m, b
open(unit=21, file="linreg.dat")
do k=0,D
  Yn(k)=m * X(k) + b
  write(21,*)X(k),Yn(k)
end do
close(21)

end program

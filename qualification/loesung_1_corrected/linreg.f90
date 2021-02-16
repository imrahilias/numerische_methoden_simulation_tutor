program linreg
  implicit none

  integer, parameter :: d=99
  double precision, dimension(0:d) :: x=0d0, y=0d0, xy=0d0, xq=0d0, yq=0d0, yn=0d0
  double precision:: sumx = 0d0, sumy = 0d0, sumxq=0d0, sumyq = 0d0, sumxy = 0d0, m = 0d0, b= 0d0
  integer:: i, n=0, k, j

  open(unit=20, file='lin-reg.txt')

  do j=0,d
     read(20,*) x(j), y(j)     !speichere in x werte in x und die y werte in die erste spalte der matrix
     print*,j, x(j), y(j)
  end do

  close(20)
  do j=0,d
     xq(j)= x(j)*x(j)
     yq(j)= y(j)*y(j)
     xy(j)= x(j)*y(j)
  end do

  do i=0, d
     sumx = sumx + x(i)
     sumy= sumy + y(i)
     sumxq= sumxq + xq(i)
     sumyq= sumyq + yq(i)
     sumxy= sumxy + xy(i)
     n = n + 1
  end do
  
  m = (n*sumxy-sumx*sumy)/(n*sumxq-sumx**2)
  b = (sumy*sumxq-sumx*sumxy)/(n*sumxq-sumx**2)
  
  print*,m, b, n
  open(unit=21, file="linreg.dat")
  do k=0,d
     yn(k)=m * x(k) + b
     write(21,*)x(k),yn(k)
  end do
  close(21)

end program linreg

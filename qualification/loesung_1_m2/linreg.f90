! moritz siegel 210215
! adapted from dr. david g. simpson, department of physical science, prince george's community college

program linreg

  implicit none
  integer, parameter :: p=selected_real_kind(16), nmax = 1e2
  integer:: i, k, j, n = 1, ios
  real(kind=p), dimension(nmax) :: x = 0, y = 0, yn = 0
  real(kind=p) :: sumx = 0, sumy = 0, sumx2 = 0, sumy2 = 0, sumxy = 0, m = 0, b= 0, r=0

  ! read data & save load order
  open(unit=20, file='lin-reg.txt')
  do while ( n .le. nmax )
     read(20, *, iostat = ios ) x(n), y(n)
     if (ios /= 0) exit
     n = n + 1
  end do  
  n = n - 1
  
  print*,  x, y
  
  sumx  = sum(x)
  sumy  = sum(y)
  sumx2 = sum(x**2)
  sumy2 = sum(y**2)
  sumxy = sum(x*y)

  m = (n * sumxy  -  sumx * sumy) / (n * sumx2 - sumx**2)
  b = (sumy * sumx2  -  sumx * sumxy) / (n * sumx2  -  sumx**2)
  r = (sumxy - sumx * sumy / n) /                                     &
       sqrt((sumx2 - sumx**2/n) * (sumy2 - sumy**2/n))

  print*, "linear regression y=xm+b on data pairs x,y:", n
  print*, "slope m:", m
  print*, "y-intercept b:", b
  print*, "correlation coefficient r:", r

  open(unit=21, file="linreg.dat")
  do k = 1,n
     yn(k) = m * x(k) + b
     write(21,*) x(k), yn(k)
  end do


end program linreg

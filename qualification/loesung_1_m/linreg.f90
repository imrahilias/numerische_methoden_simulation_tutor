! moritz siegel 210215
! adapted from dr. david g. simpson, department of physical science, prince george's community college

program linreg

  implicit none
  integer, parameter :: p=selected_real_kind(16), nmax=1e3
  integer:: i, k, j, n, ios
  real(kind=p), dimension(nmax,3) :: a = 0
  real(kind=p), dimension(nmax) :: x = 0, y = 0, xy = 0, xq = 0, yq = 0, yn = 0
  real(kind=p) :: sumx = 0, sumy = 0, sumxq = 0, sumyq = 0, sumxy = 0, m = 0, b= 0
  
  ! read data & save load order
  open(unit=20, file='lin-reg.txt')
  do n = 1,nmax
     read(20, *, iostat = ios ) a(n,1), a(n,2)
     if (ios /= 0) exit
     a(n,3) = n
     print*, a(n,:)
  end do

  ! sort ascending
  call leiter( a )

  print*, ( a(k,:), new_line('a'), k = 1,n )

  x = a(:,1)
  y = a(:,2)

  do k = 1,n
     xq(k)= x(k)*x(k)
     yq(k)= y(k)*y(k)
     xy(k)= x(k)*y(k)
  end do

  do k = 0, n
     sumx  = sumx  + x(k)
     sumy  = sumy  + y(k)
     sumxq = sumxq + xq(k)
     sumyq = sumyq + yq(k)
     sumxy = sumxy + xy(k)
  end do

  m = (n*(sumxy)-sumx*sumy)/(n*(sumxq)-sumx**2)
  b = ((sumy*sumxq)-(sumx-sumxy))/(n*sumxq-sumx**2)

  print*, m, b
  
  open(unit=21, file="linreg.dat")
  do k = 1,n
     yn(k) = m * x(k) + b
     print*, x(k), yn(k)
     write(21,*) x(k), yn(k)
  end do
  
  
contains

  
  subroutine leiter( a )

    implicit none
    real(kind=p), dimension(nmax,3) :: a
    real(kind=p), dimension(1,3) :: dummy
    integer :: irow, krow   
    do irow = 1, n
       krow = minloc( a( irow:n, 1 ), dim=1 ) + irow - 1
       dummy( 1,: ) = a( irow, : )
       a( irow, : ) = a( krow, : )
       a( krow, : ) = dummy( 1,: )
    end do
  end subroutine leiter


end program

! moritz siegel @ 210215

program interpol

  implicit none
  integer, parameter :: p=selected_real_kind(16), d = 10, n = 1e6
  integer :: i, j, k
  real(kind=p) :: xc, mix, dx, horn
  real(kind=p), dimension(d,d) :: y = 0
  real(kind=p), dimension(d) :: x = 0, c = 0

  ! read x & y
  open(unit = 20, file = 'int-pol.txt')
  do i = 1, d
     read(20, *) x(i), y(i,1)
  end do

  ! divided differences
  open(unit = 21, file = "coeff.dat")
  do j = 1, d-1
     do i = 1, d-j
        y(i,j+1) = ( y(i+1,j) - y(i,j) ) / ( x(i+j) - x(i) )
     end do
  end do
  c = y(1,:)
  write(21, *) ( i, c(i), i = 1, d )
  print*,'number ',' x ',' y ',' coefficients'
  print '(i4,f6.2,f6.2,d11.2)', ( i, x(i), y(i,1), c(i), i = 1, d )
  
  ! make x equisitant
  mix = minval(x)
  dx = abs( mix - maxval(x) ) / real( n, kind=p )

  ! polynome using horner
  open(unit = 22, file = "poly.dat")
  do i = 1, n
     xc = mix + i*dx
     write(22,*) xc, horner( xc, c, x, d )
  end do


contains


  function horner( xc, c, x, d )
    implicit none
    integer :: d, k
    real(kind=p) :: xc, c(d), x(d), horner
    horner = c(d)
    do k = d-1, 1, -1
       horner = horner * ( xc - x(k) ) + c(k)
    end do
  end function horner


end program interpol

! moritz siegel @ 210215

program interpol

  implicit none
  integer, parameter :: p=selected_real_kind( 16 ), d = 9, n = 1e6
  integer :: i = 0, j = 0, k = 0, m = 0, r = 0
  real( kind=p ) :: poly = 0d0, e = 0d0, mix, dx
  real( kind=p ), dimension( 0:d, 0:d ) :: a
  real( kind=p ), dimension( 0:d ) :: x, plnm, c

  open( unit = 20, file = 'int-pol.txt' )

  !speichere in x werte in x und die y werte in die erste spalte der matrix
  do j = 0, d
     read( 20, * ) x( j ), a( 0, j )
     print*, j, x( j ), a( 0, j )
  end do

  m = 8 !8 weil meine rechnung nicht bei der basis der pyramide startet sondern schon bei der ersten schicht
  do i = 1, d
     do r = 0, m
        a( i, r ) = ( a( i - 1, r + 1 ) - a( i - 1, r ) ) / ( x( r + i ) - x( r ) )
        print*, a( i, 0 )
     end do
     m = m - 1 !damit wenn die newton pyramide enger wird die schleife nicht versucht auf elemente zuzugreifen die außerhaöb der matrix liegen
  end do
  ! die koeffizienten des polynoms stehen jetzt in der ersten zeile des matrix aufgereiht

  print*, "koeffizienten " !testing

  open( unit = 21, file = "coeff.dat" )
  do r = 0 , d
     c( r ) = a( r, 0 )
     write( 21, * ) r, c( r )
     print*, r, c( r )
  end do

  open( unit = 22, file = "poly.dat" )
  plnm( 0 ) = c( 0 )

  ! make x equisitant
  mix = minval(x)
  dx = abs( mix - maxval(x) ) / real( n, kind=p )

  ! polynome using horner
  open(unit = 22, file = "poly.dat")
  do j = 1, n
     e = mix + j*dx
     plnm( 1 ) = c( 1 ) * ( e - x( 0 ) )
     poly = plnm( 0 ) + plnm( 1 )
     do k = 2, d
        plnm( k ) = c( k ) * ( e - x( k - 1 ) ) * plnm( k - 1 ) / c( k - 1 )
        poly = poly + plnm( k )
     end do
     write( 22, * ) e, poly
  end do


end program interpol

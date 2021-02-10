program rawk
  implicit none
  integer :: s, w, k
  integer, parameter :: nsteps = 1e3, nwalks = 1e5, rad = 1
  double precision :: r(2), e, pi = dacos(-1.d0), twopi = 2d0 * dacos(-1.d0), x, y, z, theta, phi
  double precision, dimension( nsteps ) :: res, entf

  entf = 0

  call random_seed()

  walks : do w = 1, nwalks

     x = 0d0
     y = 0d0
     z = 0d0

     steps : do s = 2, nsteps

        call random_number( r )

        theta = twopi * r( 1 ) ! inclination theta
        phi = pi * r( 2 ) ! azimuth phi

        x = x + rad * sin( theta ) * cos( phi )
        y = y + rad * sin( theta ) * sin( phi )
        z = z + rad * cos( theta )

        entf( s ) = entf( s ) + sqrt( x**2 + y**2 + z**2 )

     end do steps
  end do walks

  res = entf / nwalks

  open( unit = 20, file = 'rawk.dat' )
  do k = 1, nsteps
     write( 20,* ) k, res( k )
  end do

end program rawk

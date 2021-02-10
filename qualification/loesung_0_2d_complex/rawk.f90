program rawk
  implicit none
  integer :: s, w, k
  integer, parameter :: nsteps = 1e3, nwalks = 1e5
  double precision :: r, res( nsteps ), entf( nsteps ), twopi = 2d0 * dacos(-1.d0)
  double complex :: e

  entf = 0
  entf( 1 ) = nwalks

  call random_seed()

  do w = 1, nwalks

     e = 1d0 ! first step is in distance 1 from centre

     do s = 2, nsteps
        call random_number( r )
        e = e + exp( twopi * r ) ! delta = (-1,1)
        entf( s ) = entf( s ) + sqrt( abs( e ) )
     end do
  end do

  res = entf / nwalks

  open( unit = 20, file = 'rawk.dat' )
  do k = 1, nsteps
     write( 20,* ) k, res( k )
  end do

end program rawk

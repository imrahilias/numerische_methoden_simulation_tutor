!! moritz siegel 210609
!! reverse engeneer coupling constant j between the five tissue types [bg,wm,gm,csf,sb],
!! considering a distict j for all 25 pairs, in nearest and next nearest neighbour configuration.
!! using correctly segmented mr image, using bayes probability, coming from
!! ising model with periodic boundaries using monte carlo simulation with metropolis algorithm.

program saj

  implicit none

  integer, parameter :: p=selected_real_kind(15,32)
  !! to be edited \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  integer, parameter :: imax=254, kmax=333, nn=4 ! only nearest neighbours: set to 4
  integer, dimension(8), parameter :: inn=[1,-1,0,0,1,1,-1,-1] ! nearest & next nearest neighbour coordinates
  integer, dimension(8), parameter :: knn=[0,0,1,-1,1,-1,1,-1]
  real(kind=p), parameter :: lambda=0.98_p, ti=100_p, tf=0.01_p ! temperature settings
  real(kind=p), parameter :: weight=1._p ! weighting of posterior vs coupling (<1: less coupling, >1: more coupling)
  real(kind=p), dimension(5), parameter :: mv=[30._p,426._p,602._p,1223._p,167._p] ! [bg,wm,gm,csf,sb] mean values
  real(kind=p), dimension(5), parameter :: sigma=[30._p,59._p,102._p,307._p,69._p] ! [bg,wm,gm,csf,sb] standard deviation
  !! ////////////////////////////////////////////////////////////////////////////
  integer, dimension (imax,kmax) :: mr, cor
  integer :: i,k,n,xn,c=0, idummy,kdummy,inew,knew, typ, amount(5)=0
  real(kind=p), parameter :: size=imax*kmax
  real(kind=p), dimension (imax,kmax) :: posterior=0
  real(kind=p) :: r, t=ti, flips=0, accept=0, dist, jmean, jvar, x
  real(kind=p) :: enew, eold, deltae, jj(5,5)=1, jjnew(5,5)=1, prior(5)=0

  !! read mr & cor & count types
  open(unit=10, file='mr.dat')
  open(unit=20, file='cor.dat')
  do i = 1,imax
     do k = 1,kmax
        read(10,'(3i5)') idummy, kdummy, mr(i,k)
        read(20,'(3i5)') idummy, kdummy, cor(i,k)
        amount(cor(i,k)) = amount(cor(i,k)) + 1
     end do
     read(10,*)
     read(20,*)
  end do
  close(unit=10)
  close(unit=20)

  !! calculate prior & print type distribution.
  prior = dble(amount) / size
  write(*,*) 'weighting: ', weight
  write(*,*) 'system size:'
  write(*,*) imax,'x',kmax,':',imax*kmax, new_line('A')
  write(*,*) 'typ, amount, prior:'
  write(*,*) ( i, amount(i), prior(i), new_line('A'), i=1,5 )

  !! calculate posterior.
  open(unit=30, file='pos.dat')
  do i = 1, imax
     do k = 1, kmax
        typ = cor(i,k)

        !! calculate posterior of current setting.
        posterior(i,k) = 0.5_p * ( ((mr(i,k)) - mv(typ))/real(sigma(typ), kind=p) )**2.0_p &
             + log(dble(sigma(typ)))

        !! include prior (occurence probability) based on type prevalence.
        !posterior(i,k) = posterior(i,k) + log(prior(typ))

        write(30,*) i, k, posterior(i,k)
     end do
     write(30,*)
  end do
  close(unit=30)

  !! sweeeeep.
  open(unit=40, file='flips.dat')
  cool : do while (t .gt. tf)
     flips = 0
     c = c + 1
     t = t * lambda     

     !! calculate likelihood
     gridi : do i = 1, imax
        gridk : do k = 1, kmax
           eold = 0
           enew = 0
           
           !! pick a random neigbour.
           call random_number( x )
           xn = int( 5 * x ) + 1
           inew = i + inn(xn)
           knew = k + knn(xn)
           
           !! check periodic boundary conditions.
           if (inew .le. 0) then
              inew = imax
           else if(inew .gt. imax) then
              inew = 1
           end if
           if (knew .le. 0) then
              knew = kmax
           else if(knew .gt. kmax) then
              knew = 1
           end if

           !! set one coupling constant to -10<x<10.
           call random_number( x )
           jjnew( cor(i,k), cor(inew,knew) ) = 10 * x

           !! loop over all nearest ( & next nearest) neighbors.
           neigbour : do n = 1, nn
              inew = i + inn(n)
              knew = k + knn(n)

              !! check periodic boundary conditions.
              if (inew .le. 0) then
                 inew = imax
              else if(inew .gt. imax) then
                 inew = 1
              end if
              if (knew .le. 0) then
                 knew = kmax
              else if(knew .gt. kmax) then
                 knew = 1
              end if

              !! distance is squared vector norm for more than 8 neighbours.
              dist = 1/real(inew*inew + knew*knew, kind=p) 

              !! calculate energy to nn of old setting.
              eold = eold - jj( cor(i,k), cor(inew,knew) ) * dist

              !! calculate energy to nn of new setting.
              enew = enew - jjnew( cor(i,k), cor(inew,knew) ) * dist
              
           end do neigbour

           !! change in total energy.
           deltae = (enew - eold) * weight + posterior(i,k)
           
           ! check for floating point overflow & define r.
           if ( deltae/t .gt. 20._p ) then
              r = 0._p
           else if ( deltae/t .lt. 0.001_p ) then
              r = 1._p
           else
              r = exp(-deltae/t)
           end if

           ! accept or deny via metropolis algorithm.
           call random_number( x )
           if ( x .lt. r ) then
              jj( cor(i,k), cor(inew,knew) ) = jjnew( cor(i,k), cor(inew,knew) )
              flips = flips + 1
           end if

        end do gridk
     end do gridi

     !! print
     write(*,*) 'run: ',c, 'temperature: ',t ,'flips: ',flips
     write(40,*) c, t, flips
     accept = accept + flips

  end do cool

  !! print resulting energy.
  open(unit=50, file='energy.dat')
  do i = 1, imax
     do k = 1, kmax
        enew = 0
        
        !! loop over nearest ( & next nearest) neighbors.
        do n = 1, nn
           inew = i + inn(n)
           knew = k + knn(n)

           !! check periodic boundary conditions.
           if (inew .le. 0) then
              inew = imax
           else if(inew .gt. imax) then
              inew = 1
           end if
           if (knew .le. 0) then
              knew = kmax
           else if(knew .gt. kmax) then
              knew = 1
           end if

           !! distance is squared vector norm for more than 8 neighbours.
           dist = 1/real(inew*inew + knew*knew, kind=p)
           
           !! calculate energy to nn of new setting.
           enew = enew - jjnew( cor(i,k), cor(inew,knew) ) * dist
        end do
        
        !! change in energy & total energy.
        write(50,*) i, k, enew, enew * weight + posterior(i,k)
     end do
     write(50,*)
  end do
  close(unit=50)
  
  !! print coupling distribution.
  open(unit=60, file='jj.dat')
  write(*,*) 'coupling distribution:'
  write(*,*) jj
  write(60,*) ( ( i, k, jj(i,k), new_line('A'), i=1,5 ), k=1,5 )
  close(unit=60)
  
  ! !! statistics.
  ! jmean = sum(jj)/size
  ! jvar = sqrt( sum( (jj - jmean)**2 )/size )
  ! write(*,*) 'coupling constant statistics:'
  ! write(*,*) 'mean of j:', jmean
  ! write(*,*) 'var of j:', jvar


end program saj

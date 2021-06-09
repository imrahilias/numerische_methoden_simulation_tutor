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
  real(kind=p), parameter :: lambda=0.9_p, ti=10000_p, tf=0.001_p ! temperature settings
  real(kind=p), parameter :: weight=1._p ! weighting of posterior vs coupling (<1: less coupling, >1: more coupling)
  real(kind=p), dimension(5), parameter :: mv=[30._p,426._p,602._p,1223._p,167._p] ! [bg,wm,gm,csf,sb] mean values
  real(kind=p), dimension(5), parameter :: sigma=[30._p,59._p,102._p,307._p,69._p] ! [bg,wm,gm,csf,sb] standard deviation
  !! ////////////////////////////////////////////////////////////////////////////
  integer, dimension (imax,kmax) :: mr, cor
  integer :: i,k,n,c=0, idummy,kdummy,inew,knew, typ, amount(5)=0
  real(kind=p), parameter :: size=imax*kmax
  real(kind=p), dimension (imax,kmax) :: neighbours=0, posterior=0
  real(kind=p) :: r, t=ti, flips=0, accept=0, enew, eold, jj(5,5)=1, prior(5)=0, dist, jmean, jvar

  !! read mr & cor & count types
  open(unit=101, file='mr.dat')
  open(unit=102, file='cor.dat')
  do i = 1,imax
     do k = 1,kmax
        read(101,'(3i5)') idummy, kdummy, mr(i,k)
        read(102,'(3i5)') idummy, kdummy, cor(i,k)
        amount(cor(i,k)) = amount(cor(i,k)) + 1
     end do
     read(101,*)
     read(102,*)
  end do
  close(unit=101)
  close(unit=102)

  !! calculate prior & print type distribution.
  prior = dble(amount) / size
  write(*,*) 'weighting: ', weight
  write(*,*) 'system size:'
  write(*,*) imax,'x',kmax,':',imax*kmax, new_line('A')
  write(*,*) 'typ, amount, prior:'
  write(*,*) ( i, amount(i), prior(i), new_line('A'), i=1,5 )

  !! calculate posterior
  gridi : do i = 1, imax
     gridk : do k = 1, kmax
        typ = cor(i,k)

        !! calculate posterior of current setting.
        posterior(i,k) = 0.5_p * ( ((mr(i,k)) - mv(typ))/real(sigma(typ), kind=p) )**2.0_p &
             + log(dble(sigma(typ)))

        !! include prior (occurence probability) based on type prevalence.
        !posterior(i,k) = posterior(i,k) + log(prior(typ))

        !! loop over nearest ( & next nearest) neighbors.
        neigbour : do n = 1, nn
           dist = 1
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

           !! define distance of current to center position,
           !! distance is squared vector norm for more than 8 neighbours.
           if ( inn(n) .ne. 0 .and. knn(n) .ne. 0 ) dist = 1/real(inew*inew + knew*knew, kind=p) 

           !! calculate correlation to nn.
           if ( cor(inew,knew) .eq. typ ) neighbours(i,k) = neighbours(i,k) + dist
        end do neigbour

        !! norm & write j.
        if ( neighbours(i,k) .ne. 0 ) jj(i,k) = posterior(i,k)/( neighbours(i,k) * weight )

        write(103,*) i,k,posterior(i,k),neighbours(i,k),j0(i,k)

     end do gridk
     write(103,*)

  end do gridi
  close(unit=103)

  !! sweeeeep.
  open(unit=20, file='flips.dat')
  open(unit=103, file='j.dat')
  cool : do while (t .gt. tf)
     c = c + 1
     t = t * lambda     

     !! calculate likelihood
     gridi : do i = 1, imax
        gridk : do k = 1, kmax
           typ = cor(i,k)

           !! loop over nearest ( & next nearest) neighbors.
           neigbour : do n = 1, nn
              dist = 1
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

              !! define distance of current to center position,
              !! distance is squared vector norm for more than 8 neighbours.
              if ( inn(n) .ne. 0 .and. knn(n) .ne. 0 ) dist = 1/real(inew*inew + knew*knew, kind=p) 

              !! calculate correlation to nn.
              if ( cor(inew,knew) .eq. typ ) neighbours(i,k) = neighbours(i,k) + dist
           end do neigbour

           !! norm & write j.
           if ( neighbours(i,k) .ne. 0 ) jj(i,k) = posterior(i,k)/( neighbours(i,k) * weight )

           write(103,*) i,k,posterior(i,k),neighbours(i,k),jj(i,k)

        end do gridk

        write(103,*)

     end do gridi

  end do cool

  !! print coupling distribution.
  write(*,*) 'coupling distribution:'
  write(*,*) 'bg \t wm \t gm \t csf \t sb'
  write(*,*) ( 'bg', jj(1,i), new_line('A'), i=1,5 )
  write(*,*) ( 'wm', jj(2,i), new_line('A'), i=1,5 )
  write(*,*) ( 'gm', jj(3,i), new_line('A'), i=1,5 )
  write(*,*) ( 'csf',jj(4,i), new_line('A'), i=1,5 )
  write(*,*) ( 'sb', jj(5,i), new_line('A'), i=1,5 )

  !! statistics.
  jmean = sum(jj)/size
  jvar = sqrt( sum( (jj - jmean)**2 )/size )
  write(*,*) 'coupling constant statistics:'
  write(*,*) 'mean of j:', jmean
  write(*,*) 'var of j:', jvar


end program saj

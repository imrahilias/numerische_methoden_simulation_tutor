! bei einer matrix gehe ich aus von M(spalte, zeile)
! was passiert it nicht beschriebenen einträgen? sobald die formel keine zahl mehr findet? solange es nicht zu einem fehler kommt ist mir völlig egal was da steht
! weil ich nur die erste zeile weiter verwende
program interpol

  implicit NONE

  integer, parameter :: D=9
  integer :: i=0, j=0, k=0, M=0, r=0
  double precision :: poly=0d0, e=0d0
  real , dimension(0:D,0:D) :: a
  real , dimension(0:D) :: x, p, c

  open(unit=20, file='int-pol.txt')

  do j=0,D
      read(20,*) x(j), a(0,j)     !speichere in x werte in x und die y werte in die erste spalte der matrix
      !print*,j, x(j), a(0,j)
      end do

  close(20)


  M=8 !8 weil meine rechnung nicht bei der basis der pyramide startet sondern schon bei der ersten schicht
  do i=1, D
    do r=0, M

      a(i,r)=(a(i-1,r+1)-a(i-1,r))/(x(r+i)-x(r))
    !  print*,a(i,0)
    end do
    M=M-1 !damit wenn die newton pyramide enger wird die schleife nicht versucht auf elemente zuzugreifen die außerhaöb der matrix liegen
  end do

! Die Koeffizienten des Polynoms stehen jetzt in der ersten Zeile des Matrix aufgereiht




print*,"Koeffizienten " !testing

do r=0 , D
    print*,r,a(r,0)
    c(r) = a(r,0)
    end do

    open(unit=21, file="Poly.dat")
    p(0) = c(0)
    do j=-600,700
        e=dble(j)/1d2
        p(1) = c(1)*(e-x(0))
        poly = p(0) + p(1)
        do k=2,D
             p(k) = c(k)*(e-x(k-1))*p(k-1)/c(k-1)
             poly = poly + p(k)
             end do
        write(21,*)e,poly
        end do

close(21)








end program

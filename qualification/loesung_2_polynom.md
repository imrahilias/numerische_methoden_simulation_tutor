# loop

für die table der divided differences kann auch die laufvariable "r"
direkt limitiert werden, dann braucht man keinen zusätzlichen zähler
"m":
"
(m=m-1):
do j = 1, d-1
   do r = 1, d-j
      ...
"


# function

der größte vorteil der bestimmung der koeffizienten "c": man kann das
polynom "p" für beliebige vektoren "x" schnell ausrechnen (ordnung n
gegen 2n+1). da bietet es sich sicher an die berechnung nach horner in
eine funktion (oder subroutine) zu packen, die man dann mit einem
vektor "xc" aufruft:

"
function horner( e, c, x, d )
  horner = c(d)
  do k = d-1, 1, -1
     horner = horner * ( e - x(k) ) + c(k)
  end do
end function horner
"
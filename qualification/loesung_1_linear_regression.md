# linear regression

euer ansatz für die linear regression ist einfach, schnell, und auch
fast richtig! eine kleine änderung in line 35 ist notwendig:
(sumx-sumxy) -> (sumx*sumxy)


# regression nicht extrapolieren

eine regression darf nur in dem intervall ausgewertet werden, in dem
sie bestimmt wurde. in eurem programm lest ihr nur 9 punkte aus "d=9",
und plottet die regression dann für alle, das ist im allgemeinen nicht
aussagekräftig.


# zähler mit 0 initialisieren

wichtiger--gerade in fortran--der zähler "n" muss initialisiert
werden:
"n = 0"
sonst passiert folgendes: bei der schleife in line 31 "n = n + 1",
überprüft fortran nicht, ob die variable n schon einen wert zugewiesen
bekam oder nocht, sondern nimmt einfach das, was an dieser stelle im
ram steht, das ist dann irgendwas!


# vektor addition

ein wenig übersichtlicher sich euer code, wenn ihr statt alle werte
für "x2", "xy" und "y2" inkrementell zu multiplizieren, einfach die
vektoren multipliziert; in fortran ist das immer elementweise:

c = a * b

wenn ihr die vektoren sowieso im memory behält könnt ihr auch die
intrinsische funktion sum() verwenden, das ist bei großen vektoren ein
wenig schneller.

"
do j=0,d
 xq(j)= x(j)*x(j)
 yq(j)= y(j)*y(j)
 xy(j)= x(j)*y(j)
end do

do i=0, d
sumx = sumx + x(i)
sumy= sumy + y(i)
sumxq= sumxq + xq(i)
sumyq= sumyq + yq(i)
sumxy= sumxy + xy(i)
n = n + 1
end do
"

damit vereinfacht sich der obige code block zu:

"
sumx  = sum(x)
sumy  = sum(y)
sumx2 = sum(x**2)
sumy2 = sum(y**2)
sumxy = sum(x*y)
"

wobei spätestens bei vektoren die notation "x**2" schneller ist als "x*x".


# statistik

euer zähler "n" startet bei 0 durch die definition "dimension(0:9)",
also enspricht er nicht der anzahl der elemente sondern einem
weniger. das ist im falle dieser regressionsformel erwünscht, im
allgemeinen wäre ich damit vorsichtig.



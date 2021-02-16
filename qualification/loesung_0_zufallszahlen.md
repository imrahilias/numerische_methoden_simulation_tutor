# über pi

*twopi* als variable zu definieren is eine super idee!
wenns highest precision braucht :
"pi = dacos(-1.d0)"


# nsteps, nwalks

variablen die sich nicht ändern sollen, könnte man in die deklaration einbauen:
"integer, parameter :: nsteps = 1e3, nwalks = 1e5"


# integer overflow

nachdem *s*,*w* normale integer sind, ist der höchste mögliche wert:
"imax = 32767"
wird zb in der schleife darüber hinaus gezählt, und der compiler
gerade schläft, dann springt der wert auf:
"imax+1 = -32767"
und die schleife crashed!
zum ausprobieren einfach:
"nwalks = 1e6"
manchmal rettet der compiler unauffällig, dann gehts trotzdem.


# speed

etwa doppelt so schnell wird euer programm, wenn komplexe einheiten verwendet werden:

(x,y) => z

dann ist jeder schritt eine addition komplexer zahlen,
und eine multiplikation mit einer exponentialfunktion
(schrittlänge "step", random number "r"):

"entf = entf + step * exp( twopi * r )"



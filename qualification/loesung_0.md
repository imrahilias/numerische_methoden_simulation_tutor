# variablen


## über pi

*twopi* als variable zu definieren is eine super idee!
wenns highes precision braucht :
pi = dacos(-1.d0)


## nsteps, nwalks

könnte man in die variable declaration einbauen:
integer, parameter :: nsteps = 1e3, nwalks = 1e5


## integer overflow

Nachdem *s*,*w* normale integer sind, ist der höchste mögliche Wert:
imax = 32767,
wird zb in der Schleife darüber hinaus gezählt, dann springt der Wert auf
imax+1 = -32767,
und die Schleife crashed!
Zum Ausprobieren einfach:
nwalks = 1e6


# speed

etwa doppelt so schnell wird das programm, wenn komplexe einheiten verwendet werden:

(x,y) => z

dann ist jeder schritt eine addition komplexer zahlen,
und eine multiplikation mit einer exponentialfunktion
(schrittlänge *step*, random number *r*):

entf = entf + step * exp( twopi * r )



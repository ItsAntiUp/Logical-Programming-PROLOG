/*Kostas Ragauskas, 3 kursas, 2 grupe, variantai: 1.4, 6.4*/

/*rysiai*/
kelias(vilnius, kaunas, 100).
kelias(vilnius, utena, 160).
kelias(vilnius, marijampole, 120).
kelias(kaunas, klaipeda, 140).
kelias(kaunas, panevezys, 80).
kelias(kaunas, marijampole, 75).
kelias(panevezys, zarasai, 90).
kelias(panevezys, palanga, 150).
kelias(klaipeda, palanga, 20).
kelias(utena, zarasai, 60).

/*Uzklausu pavyzdziai:
 * galima_nuvaziuoti(utena, zarasai, 100).   (ATS: TRUE)
 * galima_nuvaziuoti(vilnius, palanga, 50).  (ATS: FALSE)
 * galima_nuvaziuoti(X, panevezys, 120).  (ATS: X = vilnius; X = kaunas)
 * galima_nuvaziuoti(kaunas, X, 110). (ATS: X = panevezys; X = marijampole, X = zarasai)
 * galima_nuvaziuoti(vilnius, kaunas, X).  (Programa neveiks!)
 *
 * dalus(s(0), 0).                        (ATS: FALSE)
 * dalus(0, s(s(0))).                     (ATS: TRUE)
 * dalus(s(s(s(s(0)))), s(s(0))).         (ATS: TRUE)
 * dalus(X, 0).                           (ATS: FALSE)
 * dalus(s(s(0)), X).                     (ATS: X = s(0), X = s(s(0)))
 * dalus(X, Y).                           (Programa dirbs be galo!)
 */


/*1.4*/
/*Arba egzistuoja tiesioginis kelias, arba kelias iki tarpinio miesto, nuo kurio galima nuvaziuoti iki tikslo*/

galima_nuvaziuoti(MiestasX, MiestasY, MaxAtstumas) :-
     kelias(MiestasX, MiestasY, Atstumas),
     Atstumas =< MaxAtstumas.

galima_nuvaziuoti(MiestasX, MiestasY, MaxAtstumas) :-
     kelias(MiestasX, TarpinisMiestas, Atstumas),
     Atstumas =< MaxAtstumas,
     galima_nuvaziuoti(TarpinisMiestas, MiestasY, MaxAtstumas).

/*6.4*/

/*0 + x = x*/
sudeti(0, X, X).

/*jeigu x + y = z, tai (x + 1) + y = (z + 1)*/
sudeti(s(X), Y, s(Z)) :- sudeti(X, Y, Z).

/*Jeigu x + y = z, vadinasi z - y = x*/
atimti(Z, Y, X) :- sudeti(X, Y, Z).

/*0 dalus is bet kokio naturalaus skaiciaus, didesnio uz 0*/
dalus(0, s(_X)).

/*Bet koks naturalusis skaicius, didesnis uz 0 yra dalus is 1*/
dalus(s(_X), s(0)).

/*X yra dalus is Y, jeigu (X - Y) = 0 arba (X - Y) yra dalus is Y*/
dalus(s(X), s(Y)) :-
     atimti(s(X), s(Y), 0).

dalus(s(X), s(Y)) :-
     atimti(s(X), s(Y), s(Z)),
     dalus(s(Z), s(Y)).

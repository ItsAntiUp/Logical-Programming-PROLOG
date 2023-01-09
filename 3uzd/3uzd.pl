/*Kostas Ragauskas, 3 kursas, 2 grupe, variantai: 1.9, 2.1, 3.1, 4.4*/

/*Uzklausu pavyzdziai:
 * knelyg([1], K).            ATS: 1
 * knelyg([1,2,3], 2).        ATS: True
 * knelyg([2,8,5,6], 3).      ATS: False
 * knelyg(S, 2).              ATS: Programa neveiks!
 *
 * nr([], 4, E).              ATS: False
 * nr([1,2,3,4], 3, E).       ATS: 3
 * nr([2,6,8,9], 1, 4).       ATS: False
 * nr([2,4,1,1], 2, 4).       ATS: True
 * nr([1,8,5], 8, E).         ATS: False
 * nr([1,8,5], NR, 8).        ATS: Programa neveiks!
 *
 * ieina([], [1,2,3]).        ATS: True
 * ieina([1,2], [2,8,1,3]).   ATS: True
 * ieina([3,4], [1,2]).       ATS: False
 * ieina([3,8], [8,5]).       ATS: False
 *
 * skirt([1,2], [6], S).      ATS: [6]
 * skirt([1,2,3], [2,3], S).  ATS: [1,0,0]
 * skirt(S1, [2,3], [1,0,0]). ATS: Programa neveiks!
 */


/*1.9 - nelyginiu skaiciu kiekis K sarase.*/
nelyginis(N) :-
     N rem 2 =:= 1.

knelyg([], 0).

knelyg([H|T], K) :-
     nelyginis(H),
     knelyg(T, M),
     K is M + 1,
     !.

knelyg([H|T], K) :-
     not(nelyginis(H)),
     knelyg(T, M),
     K is M,
     !.

/*2.1 - E yra K-tasis saraso elementas.*/
nr([], _K, false).

nr([H|_], 1, H) :-
     !.

nr([_|T], K, E) :-
     K1 is K - 1,
     nr(T, K1, E).

/*3.1 visi saraso S nariai ieina i sarasa R*/
narys(H, [H|_]).

narys(H, [_|T]) :-
     narys(H, T).

ieina([], _R).

ieina([H|T], R) :-
     narys(H, R),
     ieina(T, R),
     !.

/*4.4 Sarasu S1 ir S2 (interpretuojamu kaip skaiciai) skirtumas*/
iterpti_gale([], S, [S]).

iterpti_gale([H|T1], S, [H|T2]) :-
     iterpti_gale(T1, S, T2).

sarasaISkaiciu([H|[]], Sk, Ilgis) :-
     Sk is H,
     Ilgis is 1,
     !.

sarasaISkaiciu([H|T], Sk, Ilgis) :-
     sarasaISkaiciu(T, Sk1, Ilgis1),
     Ilgis is Ilgis1 + 1,
     Sk is H * 10^(Ilgis - 1) + Sk1.

skaiciuISarasa(Sk, [H|[]]) :-
     Sk < 10,
     H is Sk,
     !.

skaiciuISarasa(Sk, Sarasas) :-
     Sk1 is Sk // 10,
     skaiciuISarasa(Sk1, SarasoPradzia),
     Paskutinis is Sk mod 10,
     iterpti_gale(SarasoPradzia, Paskutinis, Sarasas).

skirt(S, S, [0]) :-
     !.

skirt(S, [], S) :-
     !.

skirt(S1, S2, Skirt) :-
     sarasaISkaiciu(S1, Sk1, _Len1),
     sarasaISkaiciu(S2, Sk2, _Len2),
     Skaicius is Sk1 - Sk2,
     skaiciuISarasa(Skaicius, Skirt).


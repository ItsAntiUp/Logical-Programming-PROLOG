/*Kostas Ragauskas, 3 kursas, 2 grupe, 4uzd, variantas - 1.3 */

/*Uzklausu pavyzdziai:
*
*Uzklausos, kurios randa sprendini:
*algoritmas([4, 3, 2],[4, 0.5, 0.25],[0.15, 0.45, 0.25],0.25,2,5).
*algoritmas([4, 3, 2],[4, 2.5, 0.5],[0.15, 0.05, 0.25],0.10,2,5).
*algoritmas([5, 2, 1],[3, 0.5, 1],[0.85, 0.55, 0.45],0.70,2,5).
*algoritmas([5, 4, 3],[5, 3.5, 2],[0.65, 0.33, 0.21],0.555,3,5).
*algoritmas([5, 4, 3],[5, 3.5, 2],[0.65, 0.33, 0.21],0.455,3,10).
*
*Uzklausos, grazinancios FALSE:
*algoritmas([4, 3, 2],[4, 0.0, 0.0],[0.15, 0.0, 0.0],0.10,2,5).
*algoritmas([5, 4, 3],[5, 3.5, 2],[0.65, 0.33, 0.21],0.001,3,5).
*
*/


/*
T - Kibiro talpa
P - Kibire pripilto skysèio kiekis
K - Kibire esanèio tirpalo koncentracija
Konc - Siekiama koncentracija pirmajame kibire
Tiksl - Siekiamas koncentracijos tikslumas (skaiciai po kablelio)
Busenos - Sekami kibiru pripildymai ir koncentracijos
Zingsniai - programos zingsniu (perpylimu) skaicius
Spr - Sprendinys
*/


atspausdinti_rezultatus(Spr) :-
    writeln("Kibiru pripildymas (3 reiksmes) bei ju koncentracijos:"),
    nth0(0, Spr, X),
    writeln(X),
    nth0(1, Spr, Y),
    writeln(Y).

algoritmas([T1, T2, T3], [P1, P2, P3], [K1, K2, K3], Konc, Tiksl, Zingsniai) :-
    Busenos = [],
    perpilti([T1, T2, T3], [P1, P2, P3], [K1, K2, K3], Konc, Tiksl, Busenos, Zingsniai, _Spr).

check_daugiau(Zingsniai, T2, P1, P2) :-
    Zingsniai >= 0,
    P2 < T2,
    P1 > (T2 - P2).

check_maziau(Zingsniai, T2, P1, P2) :-
    Zingsniai >= 0,
    P2 < T2,
    P1 =< (T2 - P2),
    P1 > 0.

skaiciuoti_daugiau(T2, P1, P2, K1, K2, K1_new, K2_new, P1_new, P2_new, Zingsniai, NewZingsniai) :-
    Perpilamas_kiekis is T2 - P2,
    Priemaisos is Perpilamas_kiekis * K1 + P2 * K2,
    Vanduo is Perpilamas_kiekis * (1 - K1) + P2 * (1 - K2),

    K2_new is Priemaisos / (Priemaisos + Vanduo),
    K1_new is K1,
    P2_new is P2 + Perpilamas_kiekis,
    P1_new is P1 - Perpilamas_kiekis,
    NewZingsniai is Zingsniai - 1.

skaiciuoti_maziau(P1, P2, K1, K2, K1_new, K2_new, P1_new, P2_new, Zingsniai, NewZingsniai) :-
    Perpilamas_kiekis is P1,
    Priemaisos is Perpilamas_kiekis * K1 + P2 * K2,
    Vanduo is Perpilamas_kiekis * (1 - K1) + P2 * (1 - K2),

    K2_new is Priemaisos / (Priemaisos + Vanduo),
    K1_new is 0.0,
    P2_new is P2 + Perpilamas_kiekis,
    P1_new is 0,
    NewZingsniai is Zingsniai - 1.

perpilti([_T1, _T2, _T3], [P1, P2, P3], [K1, K2, K3], Konc, Tiksl, Busenos, Zingsniai, Spr) :-
    Zingsniai >= 0,
    not(member([P1, P2, P3, K1, K2, K3], Busenos)),

    X1 is integer(K1 * (10 ^ (Tiksl+1))) div 10,
    X2 is integer(Konc * (10 ^ (Tiksl+1))) div 10,
    X1 =:= X2,

    append([], [[P1, P2, P3],[K1, K2, K3]], Spr),
    atspausdinti_rezultatus(Spr).

/*Is pirmo i antra (jei pirmame daugiau nei antrame liko vietos)*/
perpilti([T1, T2, T3], [P1, P2, P3], [K1, K2, K3], Konc, Tiksl, Busenos, Zingsniai, Spr) :-
    check_daugiau(Zingsniai, T2, P1, P2),
    not(member([P1, P2, P3, K1, K2, K3], Busenos)),
    append(Busenos, [[P1, P2, P3, K1, K2, K3]], NewBusenos),
    skaiciuoti_daugiau(T2, P1, P2, K1, K2, K1_new, K2_new, P1_new, P2_new, Zingsniai, NewZingsniai),
    perpilti([T1, T2, T3], [P1_new, P2_new, P3], [K1_new, K2_new, K3], Konc, Tiksl, NewBusenos, NewZingsniai, Spr).

/*Is pirmo i antra (jei pirmame maziau arba tiek pat kiek antrame liko vietos)*/
perpilti([T1, T2, T3], [P1, P2, P3], [K1, K2, K3], Konc, Tiksl, Busenos, Zingsniai, Spr) :-
    check_maziau(Zingsniai, T2, P1, P2),
    not(member([P1, P2, P3, K1, K2, K3], Busenos)),
    append(Busenos, [[P1, P2, P3, K1, K2, K3]], NewBusenos),
    skaiciuoti_maziau(P1, P2, K1, K2, K1_new, K2_new, P1_new, P2_new, Zingsniai, NewZingsniai),
    perpilti([T1, T2, T3], [P1_new, P2_new, P3], [K1_new, K2_new, K3], Konc, Tiksl, NewBusenos, NewZingsniai, Spr).

/**/

/*Is pirmo i trecia (jei pirmame daugiau nei treciame liko vietos)*/
perpilti([T1, T2, T3], [P1, P2, P3], [K1, K2, K3], Konc, Tiksl, Busenos, Zingsniai, Spr) :-
    check_daugiau(Zingsniai, T3, P1, P3),
    not(member([P1, P2, P3, K1, K2, K3], Busenos)),
    append(Busenos, [[P1, P2, P3, K1, K2, K3]], NewBusenos),
    skaiciuoti_daugiau(T3, P1, P3, K1, K3, K1_new, K3_new, P1_new, P3_new, Zingsniai, NewZingsniai),
    perpilti([T1, T2, T3], [P1_new, P2, P3_new], [K1_new, K2, K3_new], Konc, Tiksl, NewBusenos, NewZingsniai, Spr).

/*Is pirmo i trecia (jei pirmame maziau arba tiek pat kiek treciame liko vietos)*/
perpilti([T1, T2, T3], [P1, P2, P3], [K1, K2, K3], Konc, Tiksl, Busenos, Zingsniai, Spr) :-
    check_maziau(Zingsniai, T3, P1, P3),
    not(member([P1, P2, P3, K1, K2, K3], Busenos)),
    append(Busenos, [[P1, P2, P3, K1, K2, K3]], NewBusenos),
    skaiciuoti_maziau(P1, P2, K1, K2, K1_new, K3_new, P1_new, P3_new, Zingsniai, NewZingsniai),
    perpilti([T1, T2, T3], [P1_new, P2, P3_new], [K1_new, K2, K3_new], Konc, Tiksl, NewBusenos, NewZingsniai, Spr).

/**/

/*Is antro i pirma (jei antrame daugiau nei pirmame liko vietos)*/
perpilti([T1, T2, T3], [P1, P2, P3], [K1, K2, K3], Konc, Tiksl, Busenos, Zingsniai, Spr) :-
    check_daugiau(Zingsniai, T1, P2, P1),
    not(member([P1, P2, P3, K1, K2, K3], Busenos)),
    append(Busenos, [[P1, P2, P3, K1, K2, K3]], NewBusenos),
    skaiciuoti_daugiau(T1, P2, P1, K2, K1, K2_new, K1_new, P2_new, P1_new, Zingsniai, NewZingsniai),
    perpilti([T1, T2, T3], [P1_new, P2_new, P3], [K1_new, K2_new, K3], Konc, Tiksl, NewBusenos, NewZingsniai, Spr).

/*Is antro i pirma (jei antrame maziau arba tiek pat kiek pirmame liko vietos)*/
perpilti([T1, T2, T3], [P1, P2, P3], [K1, K2, K3], Konc, Tiksl, Busenos, Zingsniai, Spr) :-
    check_maziau(Zingsniai, T1, P2, P1),
    not(member([P1, P2, P3, K1, K2, K3], Busenos)),
    append(Busenos, [[P1, P2, P3, K1, K2, K3]], NewBusenos),
    skaiciuoti_maziau(P2, P1, K2, K1, K2_new, K1_new, P2_new, P1_new, Zingsniai, NewZingsniai),
    perpilti([T1, T2, T3], [P1_new, P2_new, P3], [K1_new, K2_new, K3], Konc, Tiksl, NewBusenos, NewZingsniai, Spr).

/**/

/*Is antro i trecia (jei antrame daugiau nei treciame liko vietos)*/
perpilti([T1, T2, T3], [P1, P2, P3], [K1, K2, K3], Konc, Tiksl, Busenos, Zingsniai, Spr) :-
    check_daugiau(Zingsniai, T3, P2, P3),
    not(member([P1, P2, P3, K1, K2, K3], Busenos)),
    append(Busenos, [[P1, P2, P3, K1, K2, K3]], NewBusenos),
    skaiciuoti_daugiau(T3, P2, P3, K2, K3, K2_new, K3_new, P2_new, P3_new, Zingsniai, NewZingsniai),
    perpilti([T1, T2, T3], [P1, P2_new, P3_new], [K1, K2_new, K3_new], Konc, Tiksl, NewBusenos, NewZingsniai, Spr).

/*Is antro i trecia (jei antrame maziau arba tiek pat kiek treciame liko vietos)*/
perpilti([T1, T2, T3], [P1, P2, P3], [K1, K2, K3], Konc, Tiksl, Busenos, Zingsniai, Spr) :-
    check_maziau(Zingsniai, T3, P2, P3),
    not(member([P1, P2, P3, K1, K2, K3], Busenos)),
    append(Busenos, [[P1, P2, P3, K1, K2, K3]], NewBusenos),
    skaiciuoti_maziau(P2, P3, K2, K3, K2_new, K3_new, P2_new, P3_new, Zingsniai, NewZingsniai),
    perpilti([T1, T2, T3], [P1, P2_new, P3_new], [K1, K2_new, K3_new], Konc, Tiksl, NewBusenos, NewZingsniai, Spr).

/**/

/*Is trecio i pirma (jei treciame daugiau nei pirmame liko vietos)*/
perpilti([T1, T2, T3], [P1, P2, P3], [K1, K2, K3], Konc, Tiksl, Busenos, Zingsniai, Spr) :-
    check_daugiau(Zingsniai, T1, P3, P1),
    not(member([P1, P2, P3, K1, K2, K3], Busenos)),
    append(Busenos, [[P1, P2, P3, K1, K2, K3]], NewBusenos),
    skaiciuoti_daugiau(T1, P3, P1, K3, K1, K3_new, K1_new, P3_new, P1_new, Zingsniai, NewZingsniai),
    perpilti([T1, T2, T3], [P1_new, P2, P3_new], [K1_new, K2, K3_new], Konc, Tiksl, NewBusenos, NewZingsniai, Spr).

/*Is trecio i pirma (jei treciame maziau arba tiek pat kiek pirmame liko vietos)*/
perpilti([T1, T2, T3], [P1, P2, P3], [K1, K2, K3], Konc, Tiksl, Busenos, Zingsniai, Spr) :-
    check_maziau(Zingsniai, T1, P3, P1),
    not(member([P1, P2, P3, K1, K2, K3], Busenos)),
    append(Busenos, [[P1, P2, P3, K1, K2, K3]], NewBusenos),
    skaiciuoti_maziau(P3, P1, K3, K1, K3_new, K1_new, P3_new, P1_new, Zingsniai, NewZingsniai),
    perpilti([T1, T2, T3], [P1_new, P2, P3_new], [K1_new, K2, K3_new], Konc, Tiksl, NewBusenos, NewZingsniai, Spr).


/**/

/*Is trecio i antra (jei treciame daugiau nei antrame liko vietos)*/
perpilti([T1, T2, T3], [P1, P2, P3], [K1, K2, K3], Konc, Tiksl, Busenos, Zingsniai, Spr) :-
    check_daugiau(Zingsniai, T2, P3, P2),
    not(member([P1, P2, P3, K1, K2, K3], Busenos)),
    append(Busenos, [[P1, P2, P3, K1, K2, K3]], NewBusenos),
    skaiciuoti_daugiau(T2, P3, P2, K3, K2, K3_new, K2_new, P3_new, P2_new, Zingsniai, NewZingsniai),
    perpilti([T1, T2, T3], [P1, P2_new, P3_new], [K1, K2_new, K3_new], Konc, Tiksl, NewBusenos, NewZingsniai, Spr).

/*Is trecio i antra (jei treciame maziau arba tiek pat kiek antrame liko vietos)*/
perpilti([T1, T2, T3], [P1, P2, P3], [K1, K2, K3], Konc, Tiksl, Busenos, Zingsniai, Spr) :-
    check_maziau(Zingsniai, T2, P3, P2),
    not(member([P1, P2, P3, K1, K2, K3], Busenos)),
    append(Busenos, [[P1, P2, P3, K1, K2, K3]], NewBusenos),
    skaiciuoti_maziau(P3, P2, K3, K2, K3_new, K2_new, P3_new, P2_new, Zingsniai, NewZingsniai),
    perpilti([T1, T2, T3], [P1, P2_new, P3_new], [K1, K2_new, K3_new], Konc, Tiksl, NewBusenos, NewZingsniai, Spr).

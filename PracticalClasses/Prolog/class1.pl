%
% Question 1
%

% a) Given the family tree, represent it in Prolog using the male,
%    female and parent predicates.

% Females
female(grace).
female(dede).
female(gloria).
female(barb).
female(claire).
female(pameron).
female(lily).
female(alex).
female(haley).
female(poppy).

% Males
male(frank).
male(phil).
male(jay).
male(javier).
male(merle).
male(mitchell).
male(joe).
male(manny).
male(cameron).
male(bo).
male(calhoun).
male(rexford).
male(luke).
male(dylan).
male(george).

% Parents

% Phil's parents
parent(grace, phil).
parent(frank, phil).

% Claire's parents
parent(dede, claire).
parent(jay, claire).

% Mitchell's parents
parent(dede, mitchell).
parent(jay, mitchell).

% Joe's parents
parent(jay, joe).
parent(gloria, joe).

% Manny's parents
parent(gloria, manny).
parent(javier, manny).

% Cameron's parents
parent(barb, cameron).
parent(merle, cameron).

% Pameron's parents
parent(barb, pameron).
parent(merle, pameron).

% Calhoun's parents
parent(bo, calhoun).
parent(pameron, calhoun).

% Rexford's parents
parent(mitchell, rexford).
parent(cameron, rexford).

% Lily's parents
parent(mitchell, lily).
parent(cameron, lily).

% Luke's parents
parent(phil, luke).
parent(claire, luke).

% Alex's parents
parent(phil, alex).
parent(claire, alex).

% Haley's parents
parent(phil, haley).
parent(claire, haley).

% George's parents
parent(dylan, george).
parent(haley, george).

% Poppy's parents
parent(dylan, poppy).
parent(haley, poppy).

% b) Using the interpreter, obtain the answers to the following questions:
%
% i. Is haley a female? female(haley) -> yes
% ii. Is Gil a male? male(Gil) -> no
% iii. Is Frank Phil's parent? parent(frank, phil) -> yes
% iv. Who are Claire's parents? parent(X, claire) -> dede, jay
% v. Who are Gloria's children? parent(gloria, x) -> joe, manny
% vi. Who are Jay's grandchildren? parent(jay, P), parent(P, G) -> luke, alex, haley, rexford, lily
% vii. Who are Lily's grandparents? parent(G, P), parent(P, lily) -> dede, jay, barb, merle
% viii. Does Alex have children? parent(Alex, C) -> no
% ix. Who is a son of Jay, but not of Gloria? parent(jay, X), \+parent(gloria, X) -> claire, mitchell

% c) Write rules that define more complex familiar relations, like father,
%    grandparent, grandmother, siblings, halfSiblings, cousins and uncle.
father(P, Child) :- parent(P, Child), male(P).
grandparent(GP, GK) :- parent(GP, P), parent(P, GK), male(GP).
grandmother(GM, GK) :- parent(GM, P), parent(P, GK), female(GM).
siblings(S1, S2) :- parent(P1, S1), parent(P1, S2), parent(P2, S1), parent(P2, S2), P1 @< P2, S1 \= S2.
halfSiblings(S1, S2) :- parent(P, S1), parent(P, S2), S1 \= S2, \+siblings(S1, S2).
cousins(A, B) :- parent(P1, A), parent(P2, B), siblings(P1, P2).
uncle(U, N) :- parent(P, N), siblings(U, P), male(U).
aunt(A, N) :- parent(P, N), siblings(P, A), female(A).

% e) What predicates would you use to represent information regarding divorce and marriage?
%
% married(Husband, Wife, Year).
%
% divorced(Husband, Wife, Year).


%
% Question 2
%

% a) Represent information relative to the curricular units, professors and students, according to the given
%    table, using the predicates leciona/2, frequenta/2, where the first argument is the curricular unit.

% Teachers
leciona(algoritmos, adalberto).
leciona(bases_de_dados, bernardete).
leciona(compiladores, capitolino).
leciona(estatistica, diogenes).
leciona(redes, ermelinda).

% Students of Algorithms
frequenta(algoritmos, alberto).
frequenta(algoritmos, bruna).
frequenta(algoritmos, cristina).
frequenta(algoritmos, diogo).
frequenta(algoritmos, eduarda).

% Students of Databases
frequenta(bases_de_dados, antonio).
frequenta(bases_de_dados, bruno).
frequenta(bases_de_dados, cristina).
frequenta(bases_de_dados, duarte).
frequenta(bases_de_dados, eduardo).

% Students of compilers
frequenta(compiladores, alberto).
frequenta(compiladores, bernardo).
frequenta(compiladores, clara).
frequenta(compiladores, diana).
frequenta(compiladores, eurico).

% Students of statistics
frequenta(estatistica, antonio).
frequenta(estatistica, bruna).
frequenta(estatistica, claudio).
frequenta(estatistica, duarte).
frequenta(estatistica, eva).

% Students of Networks
frequenta(redes, alvaro).
frequenta(redes, beatriz).
frequenta(redes, claudio).
frequenta(redes, diana).
frequenta(redes, eduardo).

% b) Use the interpreter to answer the following questions:
%
% i. Which UC does Diogenes teach? leciona(UC, diogenes) -> estatistica
% ii. Does Felismina teach any UC? leciona(UC, felismina) -> no
% iii. What UC's does Claudio go to? frequenta(UC, claudio) -> estatistica, redes
% iv. Does Dalmindo go to any UC? frequenta(UC, dalmindo) -> no
% v. Is Eduarda a student of Bernardete? -> leciona(UC, bernardete), frequenta(UC, eduarda) -> no
% vi. Do Alberto and Alvaro go to any UC in common? frequenta(UC, alberto), frequenta(UC, alvaro) -> no

% c) Write rules in Prolog that allow you to answer the following questions

% i. X is a student of professor Y?
aluno(X, Y) :- frequenta(UC, X), leciona(UC, Y).

% ii. Who are the students of professor X?
% TODO: Ask why this doesn't work.
alunos(Prof) :- leciona(UC, Prof), frequenta(UC, Y).

% iii. Who are the professors of student X?
professores(X) :- aluno(X, _).

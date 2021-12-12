%
% Question 1
%

% a) Given the family tree, represent it in Prolog using the male,
% female and parent predicates.

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
parent(jay, mithcell).

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

% b) Using the interpreter, obtain the answers to the following questions
%
% i. Is haley a female? yes
% ii. Is Gil a male? no
% iii. Is Frank Phil's parent? yes
% iv. Who are Claire's parents? dede, jay
% v. Who are Gloria's children? joe, manny
% vi.
% vii.
% viii. Does Alex have children? no
% ix.

% c) Write rules that define more complex familiar relations, like father,
%    grandparent, grandmother, siblings, halfSiblings, cousins and uncle.

father(P, Child) :- parent(P, Child), male(P).
grandparent(GP, Grandkid) :- parent(GP, X), parent(X, Grandkid), male(GP).
grandmother(GM, Grandkid) :- parent(GM, X), parent(X, Grandkid), male(GM).
siblings(S1, S2) :- parent(X, S1), parent(X, S2)

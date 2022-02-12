% participant(Id, Age, Performance).
participant(1234, 17, 'Pé Coxinho').
participant(3423, 21, 'Programar com os Pés').
participant(3788, 20, 'Sing a bit').
participant(4865, 22, 'Pontes de Esparguete').
participant(8937, 19, 'Pontes de pen-drives').
participant(2564, 20, 'Moodle hack').

% performace(Id, Times)
performance(1234, [120, 120, 120, 120]).
performance(3423, [32, 120, 45, 120]).
performance(3788, [110, 2, 6, 43]).
performance(4865, [120, 120, 110, 120]).
performance(8937, [97, 101, 105, 110]).

% Question 1
madeItThrough(Participant) :-
    performance(Participant, Scores),
    member(120, Scores).

% Question 2
mynth1(1, [Head | _], Head).
mynth1(Idx, [_ | Rest], Elem) :-
    NewIdx is Idx - 1,
    mynth1(NewIdx, Rest, Elem).

getTimes([], _, Times, Times, Total, Total).
getTimes([Participant | Rest], JuriMember, Acc, Times, Sum, Total) :-
    performance(Participant, JuriTimes),
    mynth1(JuriMember, JuriTimes, Time),
    NewSum is Sum + Time,
    append(Acc,[Time] ,NewAcc),
    getTimes(Rest, JuriMember, NewAcc, Times, NewSum, Total).

juriTimes(Participants, JuriMember, Times, Total) :-
    getTimes(Participants, JuriMember, [], Times, 0, Total).

% Question 3
getParticipants(Acc, Participants):-
    participant(Participant, _, _),
    performance(Participant, _),
    \+ member(Participant, Acc), !,
    getParticipants([ Participant | Acc], Participants).
getParticipants(Participants, Participants).

isPatient([ Head | Rest ], Acc, Total) :-
    Head =:= 120,
    NewAcc is Acc + 1,
    isPatient(Rest, NewAcc, Total).
isPatient([Head | Rest], Acc, Total) :-
    Head =\= 120,
    isPatient(Rest, Acc, Total).
isPatient([], Total, Total).

patientJuri(JuriMember) :-
    getParticipants([], Participants),
    juriTimes(Participants, JuriMember, Times, _),
    isPatient(Times, 0, Total),
    Total >= 2.

% Question 4:
sumTimes([], 0).
sumTimes([H | T], Total) :-
    sumTimes(T, NewTotal),
    Total is NewTotal + H.

bestParticipant(P1, P2, P) :-
    performance(P1, Times1),
    performance(P2, Times2),
    sumTimes(Times1, Total1),
    sumTimes(Times2, Total2),
    Total1 > Total2,
    P = P1.
bestParticipant(P1, P2, P) :-
    performance(P1, Times1),
    performance(P2, Times2),
    sumTimes(Times1, Total1),
    sumTimes(Times2, Total2),
    Total2 > Total1,
    P = P2.

% Question 5:
allPerfs :-
    participant(Id, _, Performance),
    performance(Id, Times),
    format('~d:~s:', [Id, Performance]), write(Times), nl,
    fail.
allPerfs :- true.

% Question 6:
countSuccessfulAux([Participant | Rest], Acc, T) :-
    performance(Participant, Times),
    sumTimes(Times, Total),
    length(Times, Length),
    Total =:= 120 * Length,
    NewAcc is Acc + 1,
    countSuccessfulAux(Rest, NewAcc, T).
countSuccessfulAux([Participant | Rest], Acc, T) :-
    performance(Participant, Times),
    sumTimes(Times, Total),
    length(Times, Length),
    Total =\= 120 * Length,
    countSuccessfulAux(Rest, Acc, T).
countSuccessfulAux([], T, T).

countSuccessful(Participants, T) :-
    countSuccessfulAux(Participants, 0, T).

nSuccessfulParticipants(T) :-
    getParticipants([], Participants),
    countSuccessful(Participants, T).

% Question 7:
getJuriFansAux([Time | Rest], Acc, Idx, JuriFans) :-
    Time =:= 120,
    append(Acc, [Idx], NewAcc),
    NewIdx is Idx + 1,
    getJuriFansAux(Rest, NewAcc, NewIdx, JuriFans).
getJuriFansAux([Time | Rest], Acc, Idx, JuriFans) :-
    Time =\= 120,
    NewIdx is Idx + 1,
    getJuriFansAux(Rest, Acc, NewIdx, JuriFans).
getJuriFansAux([], JuriFans, _, JuriFans).

getJuriFans(Times, JuriFans) :-
    getJuriFansAux(Times, [], 1, JuriFans).

getFansAux([Participant | Rest], Acc, Fans) :-
    performance(Participant, Times),
    getJuriFans(Times, JuriFans),
    append(Acc, [Participant-JuriFans], NewAcc),
    getFansAux(Rest, NewAcc, Fans).
getFansAux([], Fans, Fans).

getFans(Participants, Fans) :-
    getFansAux(Participants, [], Fans).

juriFans(L) :-
    getParticipants([], Participants),
    getFans(Participants, L).

% Question 8
:- use_module(library(lists)).

take(_, [], Result, Result).
take(0, _, Result, Result).
take(N, [Head | Rest], Acc, Result) :-
    NewN is N - 1,
    append(Acc, [Head], NewAcc),
    take(NewN, Rest, NewAcc, Result).

eligibleOutcome(Id, Performance, TT) :-
    performance(Id, Times),
    madeItThrough(Id),
    participant(Id, _, Performance),
    sumlist(Times, TT).

nextPhase(N, Participants) :-
    findall(
        TT-Id-Perf,
        (
            eligibleOutcome(Id, Perf, TT)
        ),
        List
    ),
    sort(List, NewList),
    length(NewList, Len),
    Len >= N,
    reverse(NewList, ReverseList),
    take(N, ReverseList, [], Participants).

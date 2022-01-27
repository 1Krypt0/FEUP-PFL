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

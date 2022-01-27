% player(Name, UserName, Age).
player('Danny', 'Best Player Ever', 27).
player('Annie', 'Worst Player Ever', 24).
player('Harry', 'A-Star Player', 26).
player('Manny', 'The Player', 14).
player('Jonny', 'A player', 16).

% game(Name, Categories, MinAge).
game('5 ATG', [action, adventure, open-world, multiplayer], 18).
game('Carrier Shift: Game Over', [action, fps, multiplayer, shooter], 16).
game('Duas Botas', [action, free, strategy, moba], 12).

% played(Player Game, HoursPlayed, PercentUnlocked)
played('Best Player Ever', '5 ATG', 3, 83).
played('Worst Player Ever', '5 ATG', 52, 9).
played('The Player', 'Carrier Shift: Game Over', 44, 22).
played('A Player', 'Carrier Shift: Game Over', 48, 24).
played('A-Star Player', 'Duas Botas', 37, 16).
played('Best Player Ever', 'Duas Botas', 33, 22).

% Question 1
achievedALot(Player) :-
    played(Player, _, _, Achieved),
    Achieved > 80.

% Question 2
isAgeAppropriate(Name, Game) :-
    player(Name, _, Age),
    game(Game, _, MinAge),
    Age >= MinAge.

% Question 3
addPlayingTimes(_, [], ListOfTimes, SumTimes, ListOfTimes, SumTimes) :- !.
addPlayingTimes(Player, [Game | Rest], Times, Sum, ListOfTimes, SumTimes) :-
    played(Player, Game, HoursPlayed, _),
    append([HoursPlayed], Times, NewHours),
    NewSum is Sum + HoursPlayed,
    addPlayingTimes(Player, Rest, NewHours, NewSum, ListOfTimes, SumTimes).

timePlayingGames(Player, Games, ListOfTimes, SumTimes) :-
    addPlayingTimes(Player, Games, [], 0, ListOfTimes, SumTimes).

mymember(X, [X | _]).
mymember(X, [_ | R]) :-
    mymember(X, R).
% Question 4
listGamesOfCategory(Cat) :-
    game(Title, Categories, MinAge),
    mymember(Cat, Categories),
    format('~s (~d)', [Title, MinAge]), nl,
    fail.
listGamesOfCategory(_).

% Question 5:
updatePlayer(Player, Game, Hours, Percentage) :-
    retract(played(Player, Game, HoursSoFar, PercentSoFar)), !,
    NewHours is HoursSoFar + Hours,
    NewPercentage is PercentSoFar + Percentage,
    assert(played(Player, Game, NewHours, NewPercentage)).

updatePlayer(Player, Game, Hours, Percentage) :-
    assert(played(Player, Game, Hours, Percentage)).

% Question 6:
fewHoursAux(Player, Acc, Games) :-
    played(Player, Game, Hours, _),
    Hours < 10,
    \+ member(Game, Acc), !,
    fewHoursAux(Player, [Game | Acc], Games).
fewHoursAux(_, Games, Games).

fewHours(Player, Games) :-
    fewHoursAux(Player, [], Games).

% Question 7:
ageRangeAux(MinAge, MaxAge, Acc, Players) :-
    player(Name, _, Age),
    Age >= MinAge,
    Age =< MaxAge,
    \+ mymember(Name, Acc),
    ageRangeAux(MinAge, MaxAge, [Name | Acc], Players).
ageRangeAux(_, _, Players, Players).

ageRange(MinAge, MaxAge, Players) :-
    ageRangeAux(MinAge, MaxAge, [], Players).

% Question 8
sumList([], Counter, Counter).
sumList([X | T], Counter, Sum) :-
    NewCounter is Counter + X,
    sumList(T, NewCounter, Sum).

averageAge(Game, AverageAge) :-
    findall(
        Age,
        (
            played(UserName, Game, _, _),
            player(_, UserName, Age)
        ),
        AgeList
    ),
    sumList(AgeList, 0, Sum),
    length(AgeList, Length),
    AverageAge is Sum / Length.

:-use_module(library(lists)).
% Question 9
get_other_players([PlayerRatio-PlayerName | Others], MaxRatio, Acc, Players) :-
    PlayerRatio =:= MaxRatio,
    get_other_players(Others, MaxRatio, [PlayerName | Acc], Players).
get_other_players([PlayerRatio-_| Others], MaxRatio, Acc, Players) :-
    PlayerRatio =\= MaxRatio,
    get_other_players(Others, MaxRatio, Acc, Players).
get_other_players([], _, Players, Players).

mostEffectivePlayers(Game, Players) :-
    findall(
        Ratio-Player,
        (
            played(Player, Game, Hours, Percentage),
            Ratio is Percentage / Hours
        ),
        List
    ),
    sort(List, SortedList),
    reverse(SortedList, [MaxRatio-BestPlayer| OtherPlayers]),
    get_other_players(OtherPlayers, MaxRatio, [BestPlayer], Players).

% Question 10
whatDoesItDo(X) :-
    player(_, X, Z), !, % Retrieve nickname and age from player
    \+ (
            played(X, G, _, _), % Player must have played the game
            game(G, _, W), % Get min age of game
            W > Z % Check if min age is bigger than player age
        ).

% Answer: The predicate returns true if a player never played a game
% innapropriate for his age, meaning he was younger than the minimum required
% age.
%
% The cut is a red one, as it prevents the predicate from retrieving all players
% that haven't broken the age restrictions.
%
% Some better names are the following:
% whatDoesItDo - playedAppropriateGames
% X - Nickname
% Z - PlayerAge
% G - Game
% W - MinGameAge

% Question 11: Idk really. Same for 12 13 and 14, sadly

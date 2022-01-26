% airport(Name, ICAO, Country).
airport('Aeroporto Francisco Sá Carneiro', 'LPPR', 'Portugal').
airport('Aeroporto Humberto Delgado', 'LPPT', 'Portugal').
airport('Aeropuerto Adolfo Suárez Madrid-Barajas', 'LEMD', 'Spain').
airport('Aéroport de Paris-Charles-de-Gaulle Roissy Airport', 'LFPG', 'France').
airport('Aeroporto Internazionale di Roma-Fiumicino - Leonardo da Vinci', 'LIRF', 'Italy').

% company(ICAO, Name, Year, Country).
company('TAP', 'TAP Air Portugal', 1945, 'Portugal').
company('RYR', 'Ryanair', 1984, 'Ireland').
company('AFR', 'Société Air France, S.A', 1933, 'France').
company('BAW', 'British Airways', 1974, 'United Kingdom').

% flight(Designation, Origin, Destination, DepartureTime, Duration, Company).
flight('TP1923', 'LPPR', 'LPPT', 1115, 55, 'TAP').
flight('TP1968', 'LPPT', 'LPPR', 2235, 55, 'TAP').
flight('TP842', 'LPPT', 'LIRF', 1450, 195, 'TAP').
flight('TP843', 'LIRF', 'LPPT', 1935, 195, 'TAP').
flight('FR5483', 'LPPR', 'LEMD', 630, 105, 'RYR').
flight('FR5484', 'LEMD', 'LPPR', 1935, 105, 'RYR').
flight('AF1024', 'LFPG', 'LPPT', 940, 155, 'AFR').
flight('AF1025', 'LPPT', 'LFPG', 1310, 155, 'AFR').

% Question 1
short(Flight) :-
    flight(Flight, _, _, _, Duration, _),
    Duration < 90.

% Question 2
shorter(Flight1, Flight2, Flight1) :-
    flight(Flight1, _, _, _, Duration1, _),
    flight(Flight2, _, _, _, Duration2, _),
    Duration1 < Duration2.
shorter(Flight1, Flight2, Flight2) :-
    flight(Flight1, _, _, _, Duration1, _),
    flight(Flight2, _, _, _, Duration2, _),
    Duration2 < Duration1.

% Question 3
arrivalTime(Flight, ArrivalTime) :-
    flight(Flight, _, _, DepartureTime, Duration, _),
    DepartureHours is DepartureTime div 100,
    DepartureMinutes is DepartureTime mod 100,
    DurationHours is Duration div 60,
    DurationMinutes is Duration mod 60,
    ArrivalHoursAux is DepartureHours + DurationHours,
    ArrivalHours is ArrivalHoursAux mod 24,
    ArrivalMinutesAux is DepartureMinutes + DurationMinutes,
    ExceedingHours is ArrivalMinutesAux div 60,
    ArrivalMinutes is ArrivalMinutesAux mod 60,
    ArrivalTime is (((ArrivalHours + ExceedingHours) mod 24) * 100) + ArrivalMinutes.

% Question 4: Idk how to do it, pls help

% Question 5: Incomplete. Lacks format, and ifs are not working
pairableFlights :-
    flight(FlightID1, _, Stop, _, _, _),
    flight(FlightID2, Stop, _, NewDeparture, _, _),
    arrivalTime(FlightID1, Arrival),
    HoursDelta is (NewDeparture div 100) - (Arrival div 100),
    MinutesDelta is (NewDeparture mod 100) - (Arrival mod 100),
    (
        MinutesDelta < 0 ->
        MinutesDelta is MinutesDelta + 60,
        HoursDelta is HoursDelta - 1
    ;
        MinutesDelta is MinutesDelta
    ),
    (
        HoursDelta < 0 ->
        HoursDelta is HoursDelta + 24
    ;
        HoursDelta is HoursDelta
    ),
    TimeDelta is (HoursDelta * 60) + MinutesDelta,
    TimeDelta >= 30,
    TimeDelta =< 90,
    write(FlightID2),
    fail.

% Question 6: Idk please help

% Question 7:
get_avg([], Size, Acc, Avg) :-
    Avg is Acc / Size.
get_avg([X | Rest], Size, Acc, Avg) :-
    NewAcc is Acc + X,
    get_avg(Rest, Size, NewAcc, Avg).

avgFlightLengthFromAirport(Airport, AvgLength) :-
    findall(
        Duration,
        (
            flight(_, Airport, _, _, Duration, _)
        ),
        List
    ),
    length(List, Size),
    get_avg(List, Size, 0, AvgLength).

% Question 8: Also idk im going to fail this exam ffs

% Question 9:
:- use_module(library(lists)).
dif_max_2(X, Y) :- X < Y, X >= Y-2.

make_pairs(L, P, [ X-Y | Zs]) :-
    select(X, L, L2),
    select(Y, L2, L3),
    G =.. [P, X, Y], G,
    make_pairs(L3, P, Zs).

%Question 10:
make_pairs(L, P, Zs) :-
    select(_X, L, L2),
    select(_Y, L2, L3),
    make_pairs(L3, P, Zs).

make_pairs([], _, []).

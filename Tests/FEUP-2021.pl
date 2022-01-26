% jogo(NJornada, EquipaCasa, EquipaFora, Resultado)
jogo(1, sporting, porto, 1-2).
jogo(1, maritimo, benfica, 2-0).
jogo(2, sporting, benfica, 0-2).
jogo(2, porto, maritimo, 1-0).
jogo(3, maritimo, sporting, 1-1).
jogo(3, benfica, porto, 0-2).

% treinadores(Equipa, [[JornadaInicio-JornadaFim]-NomeTreinador | Resto])
treinadores(sporting, [[1-2]-silas, [3-3]-ruben_amorim]).
treinadores(benfica, [[1-3]-bruno_lage]).
treinadores(maritimo, [[1-3]-jose_gomes]).
treinadores(porto, [[1-3]-sergio_conceicao]).

% Duas equipas defrontam-se apenas uma vez
% Um treinador treinou apenas uma equipa e em jornadas consecutivas

% Pergunta 1: Implemente o predicado n_treinadores(?Equipa, ?Numero)
% que determina se a Equipa teve numero de treinadores igual a Numero
n_treinadores(Equipa, Numero) :-
    treinadores(Equipa, Treinadores),
    length(Treinadores, Numero).

% Pergunta 2: Implemente o predicado
% n_jornadas_treinador(?Treinador, ?NumeroJornadas), que sucede se Treinador
% esteve a comandar a uma equipa NumeroJornadas.
get_treinador(Treinador, [Jornadas-Treinador | _ ], Jornadas).
get_treinador(Treinador, [_ | Rest], Jornadas) :-
    get_treinador(Treinador, Rest, Jornadas).

n_jornadas_treinador(Treinador, NumeroJornadas) :-
    treinadores(_, Treinadores),
    get_treinador(Treinador, Treinadores, [Start-End]),
    NumeroJornadas is End - Start + 1.

% Pergunta 3: Implemente o predicado
% ganhou(?Jornada, ?EquipaVencedora, ?EquipaDerrotada), que sucede se na Jornada
% a equipa EquipaVencedora ganhou a EquipaDerrotada
ganhou(Jornada, EquipaVencedora, EquipaDerrotada) :-
    jogo(Jornada, EquipaVencedora, EquipaDerrotada, GolosCasa-GolosFora),
    GolosCasa > GolosFora.
ganhou(Jornada, EquipaVencedora, EquipaDerrotada) :-
    jogo(Jornada, EquipaDerrotada, EquipaVencedora, GolosCasa-GolosFora),
    GolosFora > GolosCasa.

% Pergunta 4: Qual a melhor maneira de definir o operador "o" em termos
% sintaticos e semanticos?
%
% Resposta: op(180, fx, o).
% Razáo: Precedencia não importa, mas a associatividade e a posição sim.
% O operador não pode ser associativo (o operando tem de ser x), senão era
% possível escrever o benfica o sporting e seria válido. Também tem de ser uma
% operação prefixa, senão teriamos coisas como benfica o (posfixa) e
% benfica o sporting (infixo).
%
% Pergunta 5: Qual a melhor maneira de definir o operador "venceu" em termos
% sintaticos e semanticos?
%
% Resposta: op(200 , xfx, venceu).
% Razáo: Precedencia não importa, mas a associatividade e a posição sim.
% O operador não pode ser associativo (os operandos tem de ser x), senão era
% possível escrever benfica venceu sporting venceu porto e seria válido. Também
% tem de ser uma operação prefixa, senão teriamos coisas como benfica venceu
% (posfixa) e venceu benfica (prefixa). Enquanto a posfixa faria sentido, não é o
% que estamos a procura.
%
% Pergunta 6: Implemente uma regra que permita em Prolog escrever frases em
% linguagem natural como as apresentadas acima.
:- op(180, fx, o).
o X :- treinadores(X, _).

:- op(200, xfx, venceu).
o X venceu o Y :- ganhou(_, X, Y).

% Pergunta 7: Considere o predicado predX(?N,+A,+B), definido da seguinte forma
predX(N, N, _).
predX(N, A, B):-
    !,
    A \= B,
    A1 is A + sign(B - A),
    predX(N,A1,B).

% a) Descreva sucintamente o que faz o predicado predX(?N, +A, +B)
%
% Resposta: O predicado procura encontrar um valor presente no intervalo
% [A, B]. Quando N é instanciado, verifica se se encontra dentro desse intervalo.
% No caso contrário, procura todos os valores presentes no intervalo A e B.
%
% b) O cut presente no corpo da regra é verde ou vermelho? Justifique brevemente
%
% Resposta: É um cut verde, porque se a expressão A \= B falhar, significa que os
% valores de A e B são os mesmos. Para tal acontecer, a primeira condição de
% predX devia ter sido verificada. Também, se a operação de soma falhar, então
% os operadores são incompatíveis e qualquer tentativa sucessiva ia falhar.
%
% Pergunta 8: Implemente o predicado treinador_bom(?Treinador) que sucede se o
% treinador nunca perdeu um jogo ao comando da sua equipa.
treinador_bom(Treinador) :-
    treinadores(Equipa, Treinadores),
    get_treinador(Treinador, Treinadores, [Start-End]),
    \+ (
            predX(Jornada, Start, End),
            \+ ganhou(Jornada, Equipa, _),
            write(Jornada), write(' '), write(Equipa), nl
        ).

% Pergunta 9: Implemente o predicado imprime_jogos(+F) que recebe como argumento
% o nome de um predicado F de aridade 2 e cujos argumentos têm a mesma semântica
% que imprime_totobola e imprime_texto. O predicado imprime os resultados dos
% jogos no ecrã, em linhas da forma
% <Jornada J: EquipaCasa x EquipaVisitante - Output>, onde J é o número da
% jornada, EquipaCasa é a equipa da casa, EquipaVisitante é a equipa visitante e
% Output é o átomo devolvido no segundo argumento do predicado F em função do
% resultado do jogo. Os jogos devem ser impressos na mesma ordem pela qual
% aparecem na base de conhecimento (onde já estão ordenados pelo número da
% jornada). O predicado deve sempre suceder.
imprime_totobola(1, '1').
imprime_totobola(0, 'X').
imprime_totobola(-1, '2').

imprime_texto(X,'vitoria da casa'):-
    X = 1.
imprime_texto(X,'empate'):-
    X = 0.
imprime_texto(X,'derrota da casa'):-
    X = -1.

get_resultado(Jornada, Casa, Fora, 1) :-
    ganhou(Jornada, Casa, Fora), !.
get_resultado(Jornada, Casa, Fora, -1) :-
    ganhou(Jornada, Fora, Casa), !.
get_resultado(_, _, _, 0) :- !.

imprime_jogos(F) :-
    jogo(Jornada, Casa, Fora, _),
    get_resultado(Jornada, Casa, Fora, Resultado),
    Term =.. [F, Resultado, Text],
    Term,
    format('Jornada ~d: ~s x ~s - ~s', [Jornada, Casa, Fora, Text]), nl,
    fail.
imprime_jogos(_).

% Pergunta 10: Qual das afirmações está correta?
%
% Resposta: O predicado imprime_totobola é mais eficiente que imprime_texto, pois
% tira proveito do mecanismo de indexação de predicados do SICStus, que é feito
% apenas pelo functor e primeiro argumento.
%
% Pergunta 11: Considere um predicado shutdown que, quando é invocado, faz com
% que a máquina que está a correr o SICStus Prolog se desligue. Considere também
% os predicados =.. (operador "univ") e imprime_jogos,apresentado anteriormente.
%
% Entre os predicados shutdown, =.. e imprime_jogos, qual/quais são predicados
% extra-lógicos?
%
% Resposta: Apenash shutdown e imprime_jogos são extra-lógicos.
%
% Pergunta 12: Implemente o predicado lista_treinadores(?L) que unifica a lista
% L com o conjunto de treinadores que comandaram alguma equipa durante alguma
% fase do campeonato.
lista_treinadores(L) :-
    findall(
        Treinador,
        (
            treinadores(_, Treinadores),
            get_treinador(Treinador, Treinadores, _)
        ),
        L
    ), !.

% Pergunta 13: Implemente o predicado duracao_treinadores(?L) que devolve em L a
% lista de treinadores e respetivo número de jornadas em comando de uma equipa,
% ordenada por ordem decrescente segundo este número. Cada elemento é da forma
% NumeroDeJornadas-Treinador. Caso dois treinadores tenham trabalhado durante o
% mesmo número de jornadas, poderá devolvê-los em qualquer ordem na lista.
:- use_module(library(lists)).
duracao_treinadores(L) :-
    findall(
        N-Treinador,
        (
            n_jornadas_treinador(Treinador, N)
        ),
        Treinadores
    ),
    sort(Treinadores, Sorted),
    reverse(Sorted, L), !.

% Pergunta 14: Implemente o predicado pascal(+N, -L) que devolve na lista L a
% N-ésima linha do triângulo de Pascal. Cada número do triângulo de Pascal é
% igual à soma dos números imediatamente acima.
pascal(1, [1]) :- !.
pascal(N, L) :-
    N1 is N - 1,
    pascal(N1, L1),
    append([0], L1, L2),
    append(L2, [0], PreviousLine),
    sum_previous(PreviousLine, [], L), !.
sum_previous([0], L, L).
sum_previous([First, Second | Rest], L, Result) :-
    NewValue is First + Second,
    append(L, [NewValue], NewL),
    sum_previous([Second | Rest], NewL, Result).

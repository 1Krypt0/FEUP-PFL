# Five Field Kono

---

## Five Field Kono_1

| Member                             | Number      | Contribution |
| ---------------------------------- | ----------- | ------------ |
| Carolina Cintra Fernandes Figueira | up201906845 | 50%          |
| Tiago Peixoto Barreto Rodrigues    | up201907021 | 50%          |

# Installation and Execution

The game does not have any special compilation requirements and should run in any environment where SICStus Prolog is properly installed. The 4.7.0 version was used, and interoperability with other versions is not guaranteed.

One system requirement is having a font with all ASCII characters, but since that is the norm, it shouldn't be a problem.

To run the game on a graphical interface:

1. Open SICStus Prolog
2. Open `File` > `Consult` > `Select glaisher.pl located in directory /src of this project`

And if running the game on a terminal:

1. Open the SICStus Prolog REPL on the project folder
2. Type the following:

```prolog

    consult('./src/glaisher.pl').

```

After this, in both cases, the game should start running the command:

```prolog
play.
```

# Game description (350 words)

# Game Logic - implement play/0 as starting move (2400 words)

## Representation of the internal state of the game

## Visualization of the game - predicate display_game(+GameState) used for display

## Move execution - predicate move(+GameState, +Move, -NewGameState) should be used

## End Game - predicate game_over(+GameState, -Winner) should be used

## List of Valid Moves - predicate valid_moves(+GameState, -ListOfMoves) is the one to choose.

## Evaluating the game's state (OPTIONAL) - use the predicate value(+GameState, +Player, -Value)

## Choosing the computer's move - Have a difficulty level attributed (OPTIONAL HAVING MORE THAN ONE LEVEL), using the predicate choose_move(+GameState, +Level, -Move)

# Conclusion (250 words)

## Final remarks

### Positives

### Known issues

## Roadmap

# Bibliography - Books, articles and other web resources used for developing the work.

**Comment the game please**
**Screenshots can be included**

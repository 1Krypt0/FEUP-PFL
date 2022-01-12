# Trabalho Prático 2 - Five Field Kono

## Setup

In order to play our version of "Five Field Kono", it is necessary to have SICStus Prolog 4.7 installed in the machine. After starting SICStus through a shell, consult the file 'kono.pl', using the correct path. When that command is concluded, use the predicate "play." to access the game menu.

## Rules

Five Field Kono is a Korean abstract strategy game. In Korean, it is called o-pat-ko-no. <br>
By taking turns and moving pieces diagonally, one house at a time, the players try to place their pieces on the other side of the board. To win this game, a player must place all of their pieces on the opponent's starting positions. Players are allowed to move foward and backwards, but not capturing or jumping. <br>
<i>Source: (https://www.whatdowedoallday.com/five-field-kono/)</i>

## Game Logic

To create this game using Prolog, we chose the MVC design pattern. Having an understanding of the different components that constitute this project, we believe that separating Model, Controller and View is a good strategy. For a better comprehension of how these elements of the application were implemented, pleaase go through the following points:

### Internal representation of the game state

The representation of the board is made through a list of lists, in which each individual list represents a row, and a certain index in all rows represents a column. Each position of the board is either empty ("0") or filled with one, and just one, piece from a player ("1" for Player1 and "2" for Player2). Since the pieces can only move and never leave the board (there is no capturing), there is always 7 pieces from each player and the rest of the areas are empty. <br>
Our game does not require any other form of representation (e.g. pit with captured pieces), since the whole progress of the game happens in the board. <br>

![](../images/initial_board.png)

### Game state visualization

Before the game starts, the main menu is printed on the console. By choosing an option, different views for particular game settings will appear. In every menu, the functions that deal with the option selected have an implementation for invalid inputs. e.g. In the situation presented above, to choose a specific game setting the user must input 1, 2 or 3; any other input will be considered invalid and an error message will be printed on the console. <br>
After the game starts, the interface is filled with the visual representation of the board, which includes the actual 5X5 board, the symbols that illustrate rows (A-E) and columns (0-4), and a box with information of who's turn is it.

### Play execution

### Game over

### Valid plays list

## Conclusions

## Bibliography

- https://www.whatdowedoallday.com/five-field-kono/
- https://en.wikipedia.org/wiki/Five_Field_Kono

## Project Authors

This project was developed by (Group G4_05):

- Carolina Figueira up201906845
- Tiago Rodrigues up201907021

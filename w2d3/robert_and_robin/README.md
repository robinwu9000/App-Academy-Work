# Chess
A simple command-line interface [chess game](https://en.wikipedia.org/wiki/Rules_of_chess)

## Running this game
Download the chess folder in this repo and run it with
`ruby game.rb`.

## Playing it
Instructions are written on the screen, but here's a recap:

W A S D: Move the cursor  
ENTER: Select/deselect piece and select position to move to  
V: Save the game (stored as yml)  
L: Load a game (make sure you have a save file first!)  
Q: Quit the game

## Quality of Life features
+ Despite this being a CLI-based application, it highlights valid moves for the players as they hover over pieces. This includes if the King is in check or will be put in check.

+ Pieces captured are showed to the side.

+ Grid spots are numbered and lettered.
+ Special moves are included:
  + En Passant
  + Castling
  + Promotion

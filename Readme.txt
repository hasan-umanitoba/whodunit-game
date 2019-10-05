This game involves deduction to determine the "who , where and how" of a crime.
Each player makes guesses about the crime, and then other players refute that guess.
https://www.youtube.com/watch?v=sg_57S4l5Ng

psuedocode :
while game is not over:
ask active player for their guess
if guess is an accusation:
test if accusation is correct:
if correct, game is over, active player is the winner.
if not correct, active player is removed from the game.
(game is over if there is only one player remaining.)
else:
ask players if they can respond to the guess.
(starting with next player after active player)
if another player can answer the guess:
provide answer to active player
else:
report that to the active player
if game has not ended:
move to next active player.

How to run code :
-put all the files in one directory : add Main.rb and TestPlayerFixed.rb in the same directory

- to run Main.rb use the command : ruby Main.rb
- to run TestPlayer.rb : ruby TestPlayerFixed.rb



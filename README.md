#This repository is for Launch School Programming Froundations course. 

##Small command line programs in Ruby completed in this course:

###1. Calculator

A command line calculator program that does the following:

- greets user with user's name
- asks for two numbers
- asks for the type of operation to perform: add, subtract, multiply or divide
- displays the result message after the operation

###2. Rock Paper Scissor

Rock Paper Scissor game flow:

- Asks the user to make a choice
- Asks the computer to make a choice
- Displays the winner of the round
- Displays current score
- Displays the ultimate winner who won the first 5 rounds in total


## Slighly larger command line programs in Ruby completed:

### 1. Tic Tac Toe
- Displays the initial empty 3X3 board
- Lets the computer to choose the first player randomly
- Asks the user to place an empty square on the board if user is the first player
- Computer places a square
- Displays the updated board
- If winner, displays the winner
- If board is full, displays tie
- If neither winner nor board is full, repeat the game flow
- Keeps score of how many times the player wins, the first player reaches 5 points wins the game
- Adds computer AI to take attacking and defensive moves when it detects potential wins/loss moves from player
- Asks the user to play again or exit

### 2. Twenty One
- Starts with a normal 52-card deck consisting of the 4 suits (hearts, diamonds, clubs, and spades), and 13 values (2, 3, 4, 5, 6, 7, 8, 9, 10, jack, queen, king, ace). 
- Computer deals two cards with the suffled deck to player and dealer(computer) in the first round.
- The player can see his/her 2 cards, but can only see one of the dealer's cards.
- Player goes first, and needs to decide if he/she want to stay(not getting more cards) or hit(get one more card)
- When the player stays, it's the dealer's turn. The dealer must follow a strict rule for determining whether to hit or stay: hit until the total is at least 17.
- Whoever gets as close to 21 as possible wins the round, without going over. If you go over 21, it's a "bust" and you lose.
- Card values:
  | Card                 | Value      |
  | ---------------------| -----      |
  | 2 -10                | face value |
  | jack, queen, king    |  10        |
  | ace                  |  1 or 11   |
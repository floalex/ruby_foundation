require 'pry'

COMPUTER = 'Computer'
PLAYER = 'Player'
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]
                
def prompt(msg)
  puts "=> #{msg}"
end

def joinor(arr, delimiter, word="or")
  arr[-1] = "#{word} #{arr.last}" if arr.size > 1
  arr.join(delimiter)
end

def pick_first_player(current_player)
  random_choice = [COMPUTER, PLAYER].sample
  current_player << random_choice
  prompt("#{current_player.last} goes first!")
end

def alternate_player(current_player)
  if current_player.last == PLAYER
    current_player << COMPUTER
  elsif current_player.last == COMPUTER
    current_player << PLAYER
  end
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(brd)
  system 'cls'
  puts "First one reaches 5 points wins this game."
  puts "You're a #{PLAYER_MARKER}. Computer is a #{COMPUTER_MARKER}"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  | #{brd[3]}    position(left to right): 1, 2, 3"    
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  | #{brd[6]}    position(left to right): 4, 5, 6"    
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  | #{brd[9]}    position(left to right): 7, 8, 9"
  puts "     |     |"
  puts ""
end
# rubocop:disable Metrics/MethodLength, Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER } # => {1 => ' ', 2 => ' '...}
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

#computer attack/defense AI
def find_at_risk_square(line, brd, marker)
  if brd.values_at(*line).count(marker) == 2
    brd.select { |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
  else
    nil
  end
end

def place_piece!(brd, current_player)
  if current_player.last == PLAYER
     #player move
    square = ''
    loop do
      prompt("Choose a position to place a piece: #{joinor(empty_squares(brd), ', ')}")
      square = gets.chomp.to_i
      break if empty_squares(brd).include?(square)
      prompt("Sorry, that's not a valid choice")
    end
    brd[square] = PLAYER_MARKER # modify the board 
  elsif  current_player.last == COMPUTER
     #computer move
    square = nil
    
    # attack first
    WINNING_LINES.each do |line|
      square = find_at_risk_square(line, brd, COMPUTER_MARKER)
      break if square
    end
    
    # defense
    WINNING_LINES.each do |line|
      square = find_at_risk_square(line, brd, PLAYER_MARKER)
      break if square
    end
    
    # random pick
    if !square
      square = empty_squares(brd).sample
    end
    
    brd[square] = COMPUTER_MARKER
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3 #*line == line[0], line[1], line[2]; * is splat operator
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
        
  end
  nil
end

player_score = 0
computer_score = 0
current_player = []

loop do
  prompt("Welcome to Tic Tac Toe game.")
  board = initialize_board
  prompt("............................")
  pick_first_player(current_player)
  
  loop do
    display_board(board)
    place_piece!(board, current_player)
    current_player = alternate_player(current_player)
    break if someone_won?(board) || board_full?(board)
  end
  
  display_board(board)
  
  if someone_won?(board)
    prompt("#{detect_winner(board)} won!")
  else
    prompt("It's a tie")
  end
  
  player_score += 1 if detect_winner(board) == "Player"
  computer_score += 1 if detect_winner(board) == "Computer"
  
  prompt("Current score: You: #{player_score} points;  Computer: #{computer_score} points")
  break if player_score == 5 || computer_score == 5
  
  prompt("Play again? (y or n)")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')

end

if player_score == 5
  prompt("You won this game!")
elsif computer_score == 5
  prompt("Computer won this game!")
end

prompt("Thanks for playing Tick Tac Toe, good bye!")
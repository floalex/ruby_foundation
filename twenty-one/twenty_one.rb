SUITS = ['H', 'D', 'S', 'C']
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

def prompt(msg)
  puts "=> #{msg}"
end

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def total(cards)
  # cards = [['H', '3'], ['S', 'Q'], ... ]
  values = cards.map { |card| card[1] }
  
  sum = 0
  values.each do |value|
    if value == 'A'
      sum += 11
    elsif value.to_i == 0 # J, Q and K
      sum += 10
    else
      sum += value.to_i 
    end
  end
  
  # correct the ace value
  values.select { |value| value == 'A' }.count.times do 
    sum -= 10 if sum > 21
  end
  
  sum
end

def busted?(cards)
  total(cards) > 21
end

# :tie, :dealer, :player, :dealer_busted, :player_busted
def detect_result(dealer_cards, player_cards)
  player_result = total(player_cards)
  dealer_result = total(dealer_cards)
  
  if player_result > 21
    :player_busted
  elsif dealer_result > 21
    :dealer_busted
  elsif player_result > dealer_result
    :player
  elsif dealer_result > player_result
    :dealer
  else
    :tie
  end
end

def display_result(dealer_cards, player_cards, dealer_win, player_win)
  result = detect_result(dealer_cards, player_cards)
  
  case result
  when :player_busted
    prompt("You busted! Dealder wins!")
    dealer_win << 1
  when :dealer_busted
    prompt("Dealer busted! You win!")
    player_win << 1
  when :player
    prompt("You win!")
    player_win << 1
  when :dealer
    prompt("Dealer wins!")
    dealer_win << 1
  when :tie
    prompt("It's a tie.")
  end
end

def play_again?
  puts "----------------------------------"
  prompt("Do you want to play again?(y/n)")
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

prompt("Welcome to Twenty One game!")
prompt("Whoever wins five hands first, wins the game!")

player_win = []
dealer_win = []

loop do
  
  # initialize deck
  new_deck = initialize_deck
  player_cards = []
  dealer_cards = []
  
  # inital deal
  2.times do 
    player_cards << new_deck.pop
    dealer_cards << new_deck.pop
  end
  
  prompt("Dealer has #{dealer_cards[0]} and ?")
  prompt("Player has #{player_cards[0]} and #{player_cards[1]}, for a total of #{total(player_cards)}.")
  sleep 1
  
  # player turn
  loop do
    player_turn = nil
    loop do
      prompt("Do you want to (H)it or (S)tay?")
      player_turn = gets.chomp.downcase
      break if ['h', 's'].include?(player_turn)
      prompt("Sorry, must enter 'H' or 'S'.")
    end
    
    if player_turn == 'h'
      player_cards << new_deck.pop
      prompt("You chose to hit!")
      prompt("Your cards are now: #{player_cards}")
      prompt("Your total is now: #{total(player_cards)}")
    end
    
    break if player_turn == 's' || busted?(player_cards)
  end
  
  player_total = total(player_cards)
  if busted?(player_cards)
    display_result(dealer_cards, player_cards, dealer_win, player_win)
    prompt("You have #{player_win.size} score; dealer has #{dealer_win.size}")
    play_again? ? next : break
  else
    prompt("You stayed at #{player_total}")
  end
  
  # dealer turn
  prompt("Dealer turn...")
  loop do
    break if busted?(dealer_cards) || total(dealer_cards) >= 17
    
    prompt("Dealer hits!")
    dealer_cards << new_deck.pop
    prompt("Dealer cards are now: #{dealer_cards}")
  end  
    
  dealer_total = total(dealer_cards)
  if busted?(dealer_cards)
    prompt("Dealer total is now: #{dealer_total}")
    display_result(dealer_cards, player_cards, dealer_win, player_win)
    prompt("You have #{player_win.size} score; dealer has #{dealer_win.size} score")
    play_again? ? next : break
  else
    prompt("Dealer stayed at #{dealer_total}")
  end
  
  # compare cards - both player and dealer stay
  puts "==============="
  prompt("You and dealer have chosen to stay.")
  prompt("Dealer has #{dealer_cards}, for a total of: #{dealer_total}")
  prompt("Player has #{player_cards}, for a total of: #{player_total}")
  
  display_result(dealer_cards, player_cards, dealer_win, player_win)
  prompt("You have #{player_win.size} score; dealer has #{dealer_win.size} score")
  
  if player_win.size == 5 || dealer_win.size == 5
    prompt("We have a winner! This round is over.")
    break
  end
  
  break unless play_again?
end

prompt("Thank you for playing Twenty One, see you next time!")
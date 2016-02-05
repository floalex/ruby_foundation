VALID_CHOICES = %w(rock paper scissors)

def prompt(message)
  Kernel.puts("=> #{message}") 
end

def initial_score
  { player: 0, computer: 0 }
end

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
    (first == 'paper' && second == 'rock') ||
    (first == 'scissors' && second == 'paper')
end

def display_result(player, computer)
  if win?(player, computer)
    prompt("Yon won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

def update_score(score, player, computer, choice, computer_choice)
  if win?(choice, computer_choice)
    score[player] += 1
  elsif win?(computer_choice, choice)
    score[computer] += 1
  end
  end

def display_score(score)
  if score[:player] == 5
    prompt("You had 5 points now, you are the winner!")
  elsif score[:computer] == 5
    prompt("Computer has 5 points now, you lose!")
  end
end

def winning_points?(score)
  score.value?(5)
end

loop do
  prompt("First player to 5 points wins this game")
  prompt("Press crtl + c to exit any time you want")
  scores = initial_score
  choice = ''
  computer_choice = ''
  loop do
    loop do
      prompt("Choose one: #{VALID_CHOICES.join(', ')}")
      choice = Kernel.gets().chomp()
      
      if VALID_CHOICES.include?(choice)
        break
      else
        prompt("Please pick the valid options!")
      end
    end
    
    computer_choice = VALID_CHOICES.sample
  
    Kernel.puts("You chose: #{choice}; computer chose: #{computer_choice}")
    
    display_result(choice, computer_choice)
    update_score(scores, :player, :computer, choice, computer_choice)
    
    prompt("The score is: Player: #{scores[:player]}; Computer: #{scores[:computer]}")
    
    display_score(scores)
    break if winning_points?(scores)
  end
  
  prompt("Do you want to play again?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing. Good bye!")
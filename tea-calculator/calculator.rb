def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  num.to_i != 0
end

def operation_to_message(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

prompt("Welcome to Calculator! Enter your name:")

name = ''
loop do
  name = Kernel.gets().chomp()
  
  if name.empty?()
    prompt("Please enter your valid name.")
  else
    break
  end
end

prompt("Hi #{name}!")

loop do #main loop
  
  number1 = ''
  loop do 
    prompt("What's the first number?")
    number1 = Kernel.gets().chomp()
    
    if valid_number?(number1)
      break
    else
      prompt("Hmm...that doesn't look like a valid number")
    end
  end
  
  number2 = ''
  loop do
    prompt("What's the second number?")
    number2 = Kernel.gets().chomp()
    
    if valid_number?(number2)
      break
    else
      prompt("Hmm...that doesn't look like a valid number")
    end
  end
  
  operator_prompt = <<-MSG#these 3 letters can be anything as long as they match
    What operation do you want to perform?
    1) Add
    2) Subtract
    3) Mutiply
    4) Divide
  MSG
  
  prompt(operator_prompt)
  
  operator = ''
  loop do
    operator = Kernel.gets().chomp()
    
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt("Must choose 1, 2, 3, or 4")
    end
  end
  
  prompt("#{operation_to_message(operator)} the two numbers...")
  
  result = case operator
           when '1'
             number1.to_i() + number2.to_i()
           when '2'
             number1.to_i() - number2.to_i()
           when '3'
             number1.to_i() * number2.to_i()
           when '4'
             number1.to_f() / number2.to_f()
  end
  
  prompt("The result is #{result}")
  
  prompt("Do you want to perform another calculation (Y to continue)")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Good bye")
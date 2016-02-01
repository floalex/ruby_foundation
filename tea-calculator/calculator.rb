require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  Kernel.puts("=> #{message}")
end

def integer?(input)
  input.to_i.to_s == input
end

def float?(input)
  input.to_f.to_s == input
end

def number?(input)
  integer?(input) || float?(input)
end

def operation_to_message(op)
  word = case op
           when '1'
              'Adding'
           when '2'
              'Subtracting'
           when '3'
              'Multiplying'
           when '4'
              'Dividing'
         end
  word
end

prompt(MESSAGES['welcome'])

name = ''
loop do
  name = Kernel.gets().chomp()
  
  if name.empty?()
    prompt(MESSAGES['name'])
  else
    break
  end
end

prompt(MESSAGES['greet'] + " #{name}")

loop do #main loop
  
  number1 = ''
  loop do 
    prompt(MESSAGES['first_number'])
    number1 = Kernel.gets().chomp()
    
    if number?(number1)
      break
    else
      prompt(MESSAGES['invalid_number_message'])
    end
  end
  
  number2 = ''
  loop do
    prompt(MESSAGES['second_number'])
    number2 = Kernel.gets().chomp()
    
    if number?(number2)
      break
    else
      prompt(MESSAGES['invalid_number_message'])
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
      prompt(MESSAGES['operator_option'])
    end
  end
  
  prompt("#{operation_to_message(operator)} " + MESSAGES['buffer'])
  
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
  
  prompt(MESSAGES['result'] + "#{result}")
  
  prompt(MESSAGES['next_round'])
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt(MESSAGES['end'])
def prompt(message)
  Kernel.puts("=>#{message}")
end

def valid_number?(num)
  if num == "0"
    num.to_i
  else
    num.to_i != 0
  end
end

prompt("Welcome to Calculator!")

loop do
  number1 = ""
  loop do
    prompt("What's the first number?")
    number1 = Kernel.gets().chomp()

    if valid_number?(number1)
      break
    else
      prompt("That is not a valid number.")
    end
  end

  number2 = ""
  loop do
    prompt("What's the second number?")
    number2 = Kernel.gets().chomp()
    if valid_number?(number2)
      break
    else
      prompt("That is not a valid number")
    end
  end

  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) Add
    2) Subtract
    3) Multiply
    4) Divide
    MSG

  prompt(operator_prompt)

  operator = ""
  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt("Must choose 1, 2, 3, or 4")
    end
  end

  result = case operator
           when "1"
             number1.to_i() + number2.to_i()
           when "2"
             number1.to_i() - number2.to_i()
           when "3"
             number1.to_i() * number2.to_i()
           when "4"
             number1.to_f() / number2.to_f()
  end

  prompt("The result is #{result}")

  prompt("If you want to perform another calculation, enter Y")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt "Goodbye."

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  Kernel.puts("=>#{message}")
end

def float?(input)
  Float(input) rescue false
end

def integer?(input)
  Integer(input.gsub("%","")) rescue false
end

def number?(input)
  integer?(input) || float?(input)
end

def valid_loan_amount?(num)
  integer?(num)
end

def valid_apr?(num)
  number?(num)
end

def valid_loan_duration?(num)
  integer?(num)
end

def format_apr(apr)
  if integer?(apr)
    apr.to_f() / 100
  elsif float?(apr)
    apr.to_f()
  end
end

prompt(MESSAGES['greeting'])

loop do
  loan_amount = ""
  loop do
    prompt(MESSAGES['loan_amount'])
    loan_amount = Kernel.gets().chomp()

    if valid_loan_amount?(loan_amount)
      break
    else
      prompt(MESSAGES['error'])
    end
  end

  apr = ""
  loop do
    prompt(MESSAGES['apr']) #Annual Percentage Rate
    apr = Kernel.gets().chomp()

    if valid_apr?(apr)
      break
    else
      prompt(MESSAGES['error'])
    end
  end

  loan_duration = ""
  loop do
    prompt(MESSAGES['loan_duration']) #loan duration in years
    loan_duration = Kernel.gets().chomp()

    if valid_loan_duration?(loan_duration)
      break
    else
      prompt(MESSAGES['error'])
    end
  end

  n = loan_duration.to_f() * 12 # Loan duration in months

  j = format_apr(apr) / 12 # Monthly interest rate

  monthly_payment = loan_amount.to_f() * (j / (1 - (1 + j)**(-n)))

  prompt(MESSAGES['payment'])
  puts "$#{Kernel.sprintf("%.2f", monthly_payment)}"

  prompt(MESSAGES['end_prompt'])
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt(MESSAGES['goodbye'])

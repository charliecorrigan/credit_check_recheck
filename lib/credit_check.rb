class CreditCheck
  attr_reader :card_number

  def initialize(card_number)
    @card_number = card_number
  end

  def format_card_number(card_number)
    card_number.split("").reverse
  end

  def double_every_other_digit(formatted_card_number)
    formatted_card_number.map.with_index do |num, index|
      if index.odd?
        (num.to_i * 2).to_s

      else
        num
      end
    end
  end

  def sum_digits_of_numbers_over_ten(doubled_digits)
    doubled_digits.map do |num|
      if num.to_i > 9
        split_digits = num.split("")

        num = (split_digits.first.to_i + split_digits.last.to_i).to_s
      else
        num
      end
    end
  end

  def sum_of_all_digits(all_digits)
    all_digits.reduce(0) do |sum, digit|
      sum + digit.to_i
    end
  end

  def check_validity(summed_digits)
    valid = false
    if summed_digits % 10 == 0
      valid = true
    end
  end

  def run_credit_check
    formatted_number = format_card_number(card_number)
    doubled_digits = double_every_other_digit(formatted_number)
    summed_digits_over_ten = sum_digits_of_numbers_over_ten(doubled_digits)
    summed_digits = sum_of_all_digits(summed_digits_over_ten)
    valid = check_validity(summed_digits)
    if valid
      "The number is valid!" 
    else
      "The number is invalid!"
    end
  end
end

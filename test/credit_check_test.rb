require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/credit_check.rb'

class TestCreditCheck < Minitest::Test
  def test_if_it_exists
    credit_check = CreditCheck.new("4929735477250543")
    assert_instance_of CreditCheck, credit_check
  end

  def test_return_value_of_format_card_number
    credit_check = CreditCheck.new("4929735477250543")
    formatted_number = credit_check.format_card_number("4929735477250543")
    assert_equal Array, formatted_number.class
    assert_equal "4929735477250543".length, formatted_number.length
    assert_equal "4929735477250543"[-1], formatted_number.first
  end

  def test_double_every_other_digit_return_values
    credit_check = CreditCheck.new("4929735477250543")
    formatted_number = credit_check.format_card_number("4929735477250543")
    doubled_digits = credit_check.double_every_other_digit(formatted_number)
    assert_equal Array, doubled_digits.class
    assert_equal "4929735477250543".length, doubled_digits.length
    assert_equal formatted_number.first, doubled_digits.first
    refute_equal formatted_number[1], doubled_digits[1]
    assert_equal String, doubled_digits[1].class
  end

  def test_sum_digits_of_numbers_over_ten_return_values
    credit_check = CreditCheck.new("4929735477250543")
    formatted_number = credit_check.format_card_number("4929735477250543")
    doubled_digits = credit_check.double_every_other_digit(formatted_number)
    no_numbers_over_ten = credit_check.sum_digits_of_numbers_over_ten(doubled_digits)
    assert_equal Array, no_numbers_over_ten.class
    assert_equal "4929735477250543".length, no_numbers_over_ten.length
    assert_equal formatted_number.first, no_numbers_over_ten.first
    numbers_over_10 = no_numbers_over_ten.any? do |num| 
      num.to_i > 9

    end
    refute numbers_over_10
  end

  def test_if_sum_of_all_digits_returns_fixnum
    credit_check = CreditCheck.new("4929735477250543")
    formatted_number = credit_check.format_card_number("4929735477250543")
    doubled_digits = credit_check.double_every_other_digit(formatted_number)
    all_digits = credit_check.sum_digits_of_numbers_over_ten(doubled_digits)
    sum_of_digits = credit_check.sum_of_all_digits(all_digits)
    assert_equal Fixnum, credit_check.sum_of_all_digits(all_digits).class
  end

  def test_if_check_validity_returns_true
    credit_check = CreditCheck.new("4929735477250543")
    formatted_number = credit_check.format_card_number("4929735477250543")
    doubled_digits = credit_check.double_every_other_digit(formatted_number)
    all_digits = credit_check.sum_digits_of_numbers_over_ten(doubled_digits)
    sum_of_digits = credit_check.sum_of_all_digits(all_digits)
    valid = credit_check.check_validity(sum_of_digits)
    assert_equal true, valid 
  end

  def test_run_credit_check_returns_expected_values
    credit_check = CreditCheck.new("5541808923795240")
    assert_equal "The number is valid!", credit_check.run_credit_check

    credit_check = CreditCheck.new("4024007136512380")
    assert_equal "The number is valid!", credit_check.run_credit_check

    credit_check = CreditCheck.new("6011797668867828")
    assert_equal "The number is valid!", credit_check.run_credit_check

    credit_check = CreditCheck.new("5541801923795240")
    assert_equal "The number is invalid!", credit_check.run_credit_check

    credit_check = CreditCheck.new("4024007106512380")
    assert_equal "The number is invalid!", credit_check.run_credit_check

    credit_check = CreditCheck.new("6011797668868728")
    assert_equal "The number is invalid!", credit_check.run_credit_check
  end
end

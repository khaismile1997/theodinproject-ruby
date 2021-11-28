require 'active_support/all'

module Recursion
  def self.factorial(n)
    return 1 if n == 0
    n * factorial(n-1)
  end

  def self.is_palindrome(str)
    return true if str.length == 1 || str.length == 0
    if str[0] == str[-1]
      is_palindrome(str[1..-2])
    else
      false
    end
  end

  def self.bottles(n)
    return puts "no more bottles of beer on the wall" if n == 0
    puts "#{n} bottles of beer on the wall"
    bottles(n-1)
  end
  
  def self.fibonacci(n)
    return 0 if n == 0
    return 1 if n == 1
    fibonacci(n-1) + fibonacci(n-2)
  end
  
  def self.flatten(arr, rs = Array.new)
    return arr if arr.empty?
    arr.each do |el|
      if el.kind_of?(Array)
        flatten(el, rs)
      else
        rs.push(el)
      end
    end
    rs
  end

  def self.integer_to_roman(roman_mapping, number, rs = String.new)
    return rs if number == 0
    roman_mapping.keys.each do |divisor|
      quotient, modulus = number.divmod(divisor)
      rs += roman_mapping[divisor] * quotient
      return integer_to_roman(roman_mapping, modulus, rs) if quotient > 0
    end
  end
  
  def self.roman_to_integer(roman_mapping, str, rs = 0)
    return rs if str.empty?
    roman_mapping.keys.each do |roman|
      if str.start_with?(roman)
        rs += roman_mapping[roman]
        str = str.slice(roman.length, str.length)
        return roman_to_integer(roman_mapping, str, rs)
      end
    end
  end
end

# puts Recursion.factorial(6)
# puts Recursion.is_palindrome("abacaba")
# Recursion.bottles(6)
# puts Recursion.fibonacci(6)
# p Recursion.flatten([1,2,3,[4,5,[6,7]]])

# roman_mapping = {
#   1000 => "M",
#   900 => "CM",
#   500 => "D",
#   400 => "CD",
#   100 => "C",
#   90 => "XC",
#   50 => "L",
#   40 => "XL",
#   10 => "X",
#   9 => "IX",
#   5 => "V",
#   4 => "IV",
#   1 => "I"
# }

# puts Recursion.integer_to_roman(roman_mapping, 280)

# roman_mapping = {
#   "M" => 1000,
#   "CM" => 900,
#   "D" => 500,
#   "CD" => 400,
#   "C" => 100,
#   "XC" => 90,
#   "L" => 50,
#   "XL" => 40,
#   "X" => 10,
#   "IX" => 9,
#   "V" => 5,
#   "IV" => 4,
#   "I" => 1
# }

# puts Recursion.roman_to_integer(roman_mapping, "CDLVI")
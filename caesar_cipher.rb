# ref: https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-programming/lessons/caesar-cipher
require 'active_support'

def caesar_cipher(string, number)
  alphabet = ('a'..'z').to_a
  rs = ""
  string.each_char do |c|
    next rs+=c if c.blank?
    f_upper = false
    if c.match?(/\p{Upper}/)
      c.downcase!
      f_upper = true
    end
    i = alphabet.index(c)
    next rs+=c if i.nil?

    if i+number > 25
      c = alphabet[i+number-26]
    else
      c = alphabet[i+number]
    end

    if f_upper
      c.upcase!
    end
    
    rs+= c
  end
  rs
end

p caesar_cipher("What a string!", 5)
# => "Bmfy f xywnsl!"
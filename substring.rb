# ref: https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-programming/lessons/sub-strings
require 'active_support'

def substrings(string, dictionary)
  return {} if string.blank? || dictionary.blank?
  string.downcase!
  rs = {}
  dictionary.each do |word|
    count = string.scan(/(?=#{word})/).count
    next if count.zero?
    rs.merge!(Hash[word, count])
  end
  rs
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
p substrings("below", dictionary)
# => { "below" => 1, "low" => 1 }
p substrings("Howdy partner, sit down! How's it going?", dictionary)
# => { "down" => 1, "go" => 1, "going" => 1, "how" => 2, "howdy" => 1, "it" => 2, "i" => 3, "own" => 1, "part" => 1, "partner" => 1, "sit" => 1 }
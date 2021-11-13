# ref: https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-programming/lessons/sub-strings
require 'active_support'

def stock_picker(arr)
  return [] if arr.blank?
  min_price = arr[0]
  min_price_index = 0
  max_profit = 0
  max_profit_index = 0
  rs = []
  # => O(n)
  arr.each_with_index do |price, i|
    next (min_price = price; min_price_index = i) if price < min_price
    if price - min_price > max_profit
      max_profit = price - min_price
      max_profit_index = i
      rs = [min_price_index, max_profit_index]
    end
  end
  # => O(n^2)
  # (0..arr.length-1).each do |i|
  #   (i+1..arr.length-1).each do |j|
  #     if arr[j]-arr[i] > max
  #       max_profit = arr[j]-arr[i]
  #       rs = [i, j]
  #     end
  #   end
  # end
  rs
end

p stock_picker([17,3,6,9,15,8,6,1,10])
# => [1,4]

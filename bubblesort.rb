# ref: https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-programming/lessons/sub-strings
require 'active_support'

def bubble_sort(arr)
  return [] if arr.blank?
  (0...arr.length).each do |i|
    flag_swap = false
    (0...arr.length-i-1).each do |j|
      if arr[j] > arr[j+1]
        temp = arr[j]
        arr[j] = arr[j+1]
        arr[j+1] = temp
        flag_swap = true
      end
    end
    
    break unless flag_swap
  end
  arr
end

p bubble_sort([4,3,78,2,0,2])
# => [0,2,2,3,4,78]

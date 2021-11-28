require 'active_support'

def merge_sort(arr)
  # base case
  return arr if arr.length < 2
  middle = arr.length / 2
  # sort left
  left_half = merge_sort(arr[0...middle])
  # sort right
  right_half = merge_sort(arr[middle..arr.length])
  # merge two halves

  sorted = Array.new
  until left_half.empty? || right_half.empty?
    left_half[0] <= right_half[0] ? sorted.push(left_half.shift) : sorted.push(right_half.shift)
  end

  sorted + left_half + right_half
end

p merge_sort([4,3,78,2,0,2])
# => [0,2,2,3,4,78]

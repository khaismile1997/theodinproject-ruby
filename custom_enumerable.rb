require 'active_support/all'

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?
    for el in self do     
      yield el
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    for el in self do
      yield el, self.index(el)
    end
  end
  
  def my_select
    return to_enum(:select) unless block_given?
    if is_a?(Hash)
      result = {}
      my_each { |k, v| result.merge!(Hash[k,v]) if yield k, v }
    else
      result = []
      my_each { |el| result.push(el) if yield el }
    end
    result
  end
  
  def my_all?
    if block_given?
      my_each {|el| return false unless yield el}
    else
      for el in self
        return false unless el
      end
    end
    true
  end

  def my_any?
    if block_given?
      my_each {|el| return true if yield el}
    else
      for el in self
        return true if el
      end
    end
    false
  end

  def my_none?
    if block_given?
      my_each {|el| return false if yield el}
    else
      for el in self
        return false if el
      end
    end
    true
  end
  
  def my_count
    count = 0
    if block_given?
      my_each {|el| count+=1 if yield el}
    else
      for el in self
        count+=1
      end
    end
    count
  end
  
  def my_map(proc=nil)
    return to_enum(:my_map) unless block_given? || proc
    result = []
    my_each do |el|
      result.push(proc ? proc.call(el) : yield(el))
    end
    result
  end

  def my_inject(init = nil, operator = nil)
    if init.instance_of?(Symbol)
      operator = init
      init = nil
    end
    accumulator = init ? init : self.first
    shifted = is_a?(Hash) ? slice(keys[1], keys[-1]) : self[1..-1]
    operator_block = lambda {|el| accumulator = accumulator.send(operator, el)}
    standard_block = lambda {|el| accumulator = yield accumulator, el}

    if init && operator
      my_each(&operator_block)
    elsif init
      my_each(&standard_block)
    elsif operator
      shifted.my_each(&operator_block)
    else
      shifted.my_each(&standard_block)
    end
    accumulator
  end
end

# Test my_each
# [1,2,3].my_each{|n| puts n}
# [1,2,3].each{|n| puts n}

# Test my_each_with_index
# [1,2,3].my_each_with_index{|el, i| puts el; puts i}
# [1,2,3].each_with_index{|el, i| puts el; puts i}

# Test my_select
# puts [1,2,3,4,5,6].select{|n| n.even?}
# puts [1,2,3,4,5,6].my_select{|n| n.even?}
# hash = {:a => 1, :b => 2, :c => 3, :d => 4}
# a = hash.select do |k, v|
#   v.even?
# end
# puts a
# b = hash.my_select do |k, v|
#   v.even?
# end
# puts b

# Test my_all?
# puts [1,2,3,nil].all?
# puts [1,2,3,nil].my_all?
# h = {:a => 1, :b => 2, :c => 3, :d => nil}
# puts h.all?
# puts h.my_all?

# puts [2,4,6].all?{|n| n.even?}
# puts [2,4,6].my_all?{|n| n.even?}
# h = {:a => 1, :b => 2, :c => 3, :d => 4}
# puts h.all?{|k,v| k.present? && v.present?}
# puts h.my_all?{|k,v| k.present? && v.present?}

# Test my_any?
# puts [1,2,3,nil].any?
# puts [1,2,3,nil].my_any?
# h = {:a => 1, :b => 2, :c => 3, :d => nil}
# puts h.any?
# puts h.my_any?

# puts [2,3,5].any?{|n| n.even?}
# puts [2,3,5].my_any?{|n| n.even?}
# h = {:a => 1, :b => 2, :c => 3, nil => nil}
# puts h.any?{|k,v| k.present? && v.present?}
# puts h.my_any?{|k,v| k.present? && v.present?}

# Test my_none?
# puts [1,2,3,nil].none?
# puts [1,2,3,nil].my_none?
# puts [nil,nil,nil].none?
# puts [nil,nil,nil].my_none?
# h = {:a => 1, :b => 2, :c => 3, :d => nil}
# puts h.none?
# puts h.my_none?

# puts [2,4,6].none?{|n| n.odd?}
# puts [2,4,6].my_none?{|n| n.odd?}
# h = {:a => 1, :b => 2, :c => 3, :d => nil}
# puts h.none?{|k,v| k.present? && v.present?}
# puts h.my_none?{|k,v| k.present? && v.present?}

# Test my_count
# puts [1,2,3,nil].count
# puts [1,2,3,nil].my_count
# puts [nil,nil,nil].count
# puts [nil,nil,nil].my_count
# h = {:a => 1, :b => 2, :c => 3, :d => nil}
# puts h.count
# puts h.my_count

# puts [2,4,6].count{|n| n.even?}
# puts [2,4,6].my_count{|n| n.even?}
# h = {:a => 1, :b => 2, :c => 3, :d => nil}
# puts h.count{|k,v| k.present? && v.present?}
# puts h.my_count{|k,v| k.present? && v.present?}

# Test my_map
# puts [1,2,3,nil].my_map
# puts [1,2,3,nil].my_map
# h = {:a => 1, :b => 2, :c => 3, :d => nil}
# puts h.map
# puts h.my_map

# puts [2,4,6].map{|n| n.even?}
# puts [2,4,6].my_map{|n| n.even?}
# p [2,4,6].map{|n| n.to_s}
# p [2,4,6].my_map{|n| n.to_s}
# proc_test = Proc.new {|x| x.length}
# puts ["a","ab","abc"].map(&proc_test)
# puts ["a","ab","abc"].my_map(&proc_test)
# h = {:a => 1, :b => 2, :c => 3, :d => nil}
# p h.map{|k,v| k.to_s}
# p h.my_map{|k,v| k.to_s}
# proc_test = Proc.new {|k,v| v.to_s.length}
# p h.map(&proc_test)
# p h.my_map(&proc_test)


# Test my_inject
# puts [1,2,3].inject(1) {|a, x| a*=x }
# puts [1,2,3].my_inject(1) {|a, x| a*=x}
# puts [1,2,3].inject(:*)
# puts [1,2,3].my_inject(:*)
# h = {:a => 1, :b => 2, :c => 3, :d => nil}
# puts h.inject({e: 4}) {|a, e| a.merge!(Hash[e[0], e[1]])}
# puts h.my_inject({e: 4}) {|a, e| a.merge!(Hash[e[0], e[1]])}

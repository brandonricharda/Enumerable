module Enumerable
    def my_each
        self.length.times { |i| yield self[i] }
    end
    
    def my_each_with_index
        self.length.times { |i| yield self[i], i }
    end

    def my_select
        result_array = []
        self.my_each { |i| result_array << i unless !yield(i) }
        result_array
    end

    def my_all?
        result = true
        self.my_each { |i| result = false unless yield(i) }
        result
    end

    def my_any?
        result = false
        self.my_each { |i| result = true if yield(i) }
        result
    end

    def my_none?
        result = true
        self.my_each { |i| result = false if yield(i) }
        result
    end

    def my_count
        result = 0
        self.my_each { |i| result += 1 if yield(i) }
        result
    end

    def my_map (x = nil)
        if x == nil
            result = []
            self.my_each { |i| result.push(yield(i)) }
            result
        else
            result = []
            self.my_each { |i| result.push x.call(i) }
            result
        end
    end

    def my_inject
        result = self.first
        self.my_each_with_index do |item, index|
            next if index == 0
            result = yield(result, item)
        end
        result
    end

    def multiply_els
        self.my_inject { |total, item| total * item }
    end

end

#[1, 2, 3, 4, 5].my_each { |item| puts item * 2 }

#[1, 2, 3, 4, 5].my_each_with_index { |item, index| puts "Element is #{item} and index is #{index}" }

#[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].my_select { |item| item % 2 == 0 }

#puts [3, 5, 9].my_all? { |item| item % 2 == 0 }

#puts [1, 3, 5, 2].my_any/ { |item| item % 2 == 0 }

#puts [1, 2, 3, 4, 5, 10].my_none? { |item| item % 10 == 0 }

#puts [1, 3, 5, 7].my_count { |item| item % 2 == 0 }

#puts [1, 2, 3, 4, 5].my_map { |item| item * 2 }

#my_proc = Proc.new { |item| item * 3 }

#puts [1, 2, 3, 4, 5].my_map(my_proc)

#puts [1, 2, 3, 4, 5].my_inject { |total, element| total * element }

#puts [2, 4, 5].multiply_els
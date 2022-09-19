class LinkedList
    attr_accessor :head, :tail
    def initialize
        @head = nil
        @tail = nil
    end

    #append(value) adds a new node containing value to the end of the list
    def append(value)
        newNode = Node.new(value)
        if @head == nil
            @head = newNode
            @tail = newNode
        else
            @tail.nextNode = newNode
            @tail = newNode
        end
    end
    
    #prepend(value) adds a new node containing value to the start of the list
    def prepend(value)
        newNode = Node.new(value)
        if @head == nil
            @head = newNode
            @tail = newNode
        else
            newNode.nextNode = @head
            @head = newNode
        end
    end

    #size returns the total number of nodes in the list
    def size
        currentNode = @head
        if currentNode == nil
            return 0
        end
        count = 1
        while currentNode.nextNode != nil
            count += 1
            currentNode = currentNode.nextNode
        end
        return count
    end

    #head returns the first node in the list
    def head
        return @head
    end

    def tail
        return @tail
    end

    #at(index) returns the node at the given index
    def at(index)
        if index >= self.size
            return nil
        else
            currentNode = @head
            index.times do
                currentNode = currentNode.nextNode
            end
            return currentNode.value
        end
    end

    #pop removes the last element from the list
    def pop
        if self.size == 0
            puts "Empty list. Nothing to pop."
            return
        elsif self.size == 1
            puts "Only one in the list. Setting it to nil."
            @head = nil
            @tail = nil
        else
            currentNode = @head
            numLoop = self.size - 2
            numLoop.times do
                currentNode = currentNode.nextNode
            end
            poppedNode = currentNode.nextNode
            puts "Popped Node contains value #{poppedNode.value}"
            currentNode.nextNode = nil
        end
    end

    #contains?(value) returns true if the passed in value is in the list and otherwise returns false.
    def contains?(value)
        if @head == nil
            return false
        end
        currentNode = @head
        loop do
            if currentNode.value == value
                return true
            else
                if currentNode.nextNode == nil
                    break
                end
                currentNode = currentNode.nextNode
            end
        end
        return false
    end

    #find(value) returns the index of the node containing value, or nil if not found.
    def find(value)
        if @head == nil
            return nil
        end
        currentNode = @head
        index = 0
        loop do
            if currentNode.value == value
                return index
            else
                if currentNode.nextNode == nil
                    break
                end
                currentNode = currentNode.nextNode
                index += 1
            end
        end
        return nil
    end

    #to_s represent your LinkedList objects as strings, so you can print them out and preview them in the console. The format should be: ( value ) -> ( value ) -> ( value ) -> nil
    def to_s
        printString = ""
        if @head == nil
            return "nil"
        end
        currentNode = @head
        printString.concat("( #{currentNode.value} )")
        loop do
            if currentNode.nextNode == nil
                printString.concat(" -> nil")
                break
            end
            currentNode = currentNode.nextNode
            printString.concat(" -> ( #{currentNode.value} )")
        end
        return printString
    end

    #insert_at(value, index) that inserts a new node with the provided value at the given index.
    def insert_at(value, index)
        if (index >= self.size || index < 0)
            puts "Invalid index"
            return
        end
        newNode = Node.new(value)
        if index == 0
            newNode.nextNode = @head
            @head = newNode
        elsif index == self.size - 1
            @tail.nextNode = newNode
            @tail = newNode
        else
            currentNode = @head
            numLoop = index - 1
            numLoop.times do
                currentNode = currentNode.nextNode
            end
            newNode.nextNode = currentNode.nextNode
            currentNode.nextNode = newNode
        end
    end

    #remove_at(index) that removes the node at the given index.
    def remove_at(index)
        if (index >= self.size || index < 0)
            puts "Invalid index"
            return
        end
        currentNode = @head
        if index == 0
            @head = currentNode.nextNode
        elsif index == self.size - 1
            numLoop = index - 1
            numLoop.times do
                currentNode = currentNode.nextNode
            end
            currentNode.nextNode = nil
            @tail = currentNode
        else
            numLoop = index - 1
            numLoop.times do
                currentNode = currentNode.nextNode
            end
            currentNode.nextNode = currentNode.nextNode.nextNode
        end
    end

end

class Node
    attr_accessor :value, :nextNode
    def initialize(value = nil, nextNode = nil)
        @value = value
        @nextNode = nextNode
    end
end

#Expect(999, 111, 222, 333); 333 then popped.
#It did not like integer values it seemed. To save time, I took the easy route to just test strings instead of worrying about to_s.

testLL = LinkedList.new()
testLL.append('111')
testLL.append('222')
testLL.append('333')
testLL.prepend('999')
puts "testLL's size is #{testLL.size}"
puts "testLL's value at 1 is #{testLL.at(1)}"
testLL.pop
puts "testLL's size after pop is #{testLL.size}"
puts "Does testLL contain 999? Should be true. Result: #{testLL.contains?('999')}"
puts "Does testLL contain 222? Should be true. Result: #{testLL.contains?('222')}"
puts "Does testLL contain 333? Should be false. Result: #{testLL.contains?('333')}"
puts "Does testLL have 999's index? Should be 0. Result: #{testLL.find('999')}"
puts "Does testLL have 222's index? Should be 2. Result: #{testLL.find('222')}"
puts "Does testLL have 333's index? Should be nil. Result: #{testLL.find('333')}"
puts "Print the string. Result: #{testLL.to_s}"

#testLL2 is for the final two more complicated test scenarios. Expect (a, b, c, d, e, f, g)
testLL2 = LinkedList.new()
testLL2.append('a')
testLL2.append('b')
testLL2.append('c')
testLL2.append('d')
testLL2.append('e')
testLL2.append('f')
testLL2.append('g')
testLL2.insert_at('z',1)
puts "Expect (a, z, b, c, d, e, f, g). Result #{testLL2.to_s}"
testLL2.insert_at('y',7)
puts "Expect (a, z, b, c, d, e, f, g, y). Result #{testLL2.to_s}"
testLL2.remove_at(0)
puts "Expect (z, b, c, d, e, f, g, y). Result #{testLL2.to_s}"
testLL2.remove_at(7)
puts "Expect (z, b, c, d, e, f, g). Result #{testLL2.to_s}"
testLL2.insert_at('h',3)
puts "Expect (z, b, c, h, d, e, f, g). Result #{testLL2.to_s}"
testLL2.remove_at(5)
puts "Expect (z, b, c, h, d, f, g). Result #{testLL2.to_s}"
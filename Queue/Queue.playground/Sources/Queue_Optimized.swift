/*
Reference : https://github.com/raywenderlich/swift-algorithm-club

 First-in first-out queue (FIFO)
 Enqueuing and dequeuing are O(1) operations.
*/
import Foundation

public struct QueueOptimized<T> {
    private var array = [T?]()
    private var head = 0
    
    public init() {
        
    }
    
    public init(array: [T?]) {
        self.array = array
    }
    
    public var count: Int {
        return array.count - head
    }
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func dequeue() -> T? {
        guard let element = array[guarded: head]  else {
            return nil
        }
        
        array[head] = nil
        head += 1
        
        let percentage = Double(head)/Double(array.count)
        if array.count > 50 && percentage > 0.25 {
            array.removeFirst(head)
            head = 0
        }
        
        return element
    }
    
    public var front: T? {
        if isEmpty {
            return nil
        } else {
            return array[head]
        }
    }
    
    public func getElement() -> [T?] {
        return array
    }
}

extension Array {
    subscript(guarded idx: Int) -> Element? {
        guard (startIndex..<endIndex).contains(idx) else {
            return nil
        }
        
        return self[idx]
    }
}

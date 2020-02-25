/*
Reference : https://github.com/raywenderlich/swift-algorithm-club

 First-in first-out queue (FIFO)
 Enqueuing is an O(1) operation,
 dequeuing is O(n)
*/
import Foundation

public struct QueueSimple<T> {
    var array = [T]()
    
    public init() {
        
    }
    
    public init(array: [T]) {
        self.array = array
    }
    
    public var count: Int {
        return array.count
    }
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        }
        
        return array.removeFirst()
    }
    
    public var front: T? {
        return array.first
    }
    
    public func getElement() -> [T] {
        return array
    }
}

/*
 Reference : https://github.com/raywenderlich/swift-algorithm-club
 
        Average Worst-Case
 Space:   O(n)     O(n)
 Search:  O(1)     O(n)
 Insert:  O(1)     O(n)
 Delete:  O(1)     O(n)
 */

import Foundation

public struct HashTable<Key: Hashable, Value> {
    private typealias Element = (key: Key, value: Value)
    private typealias Bucket = [Element]
    private var buckets = [Bucket]()
    
    private var initialCapacity: Int = 0
    
    /// The number of key-value pairs in the hash table.
    private(set) public var count = 0
    
    /// A Boolean value that indicates whether the hash table is empty.
    public var isEmpty: Bool { return count == 0 }
    
    /// Create a hash table with the given capacity.
    /// - Parameter capacity: Initail size of Table
    public init(capacity: Int) {
        assert(capacity > 0)
        buckets = Array<Bucket>(repeatElement([], count: capacity))
        initialCapacity = capacity
    }
    
    /*
     Accesses the value associated with the given key for reading and writing.
     */
    public subscript(key: Key) -> Value? {
        get {
            return value(forKey: key)
        }
        set {
            if let value = newValue {
                updateValue(value, forKey: key)
            } else {
                removeValue(forKey: key)
            }
        }
    }
    
    /// Returns the value for the given key.
    /// - Parameter key: key
    public func value(forKey key: Key) -> Value? {
        let index = self.index(forKey: key)
        for element in buckets[index] {
            if element.key == key {
                return element.value
            }
        }
        
        return nil // key not in hash table
    }
    
    /// Upate the value stored in the hash table for the given key,
    /// or adds a new key-value pair if the key does not exist.
    /// - Parameters:
    ///   - value: value
    ///   - key: key
    @discardableResult public mutating func updateValue(_ value: Value, forKey key: Key) -> Value? {
        let index = self.index(forKey: key)
        
        // Do we already have this key in the buckets?
        for (i, element) in buckets[index].enumerated() {
            if element.key == key {
                let oldValue = element.value
                buckets[index][i].value = value
                return oldValue
            }
        }
        
        // This key isn't in the buckets yet; add it to the chain
        doTableDoubling()
        addElement(value, forKey: key)
        
        return nil
    }
    
    /// Remove the given key and its
    /// associated value from the hash table.
    /// - Parameter key: key
    @discardableResult public mutating func removeValue(forKey key: Key) -> Value? {
        doTableDoubling()
        
        let index = self.index(forKey: key)
        
        for (i, element) in buckets[index].enumerated() {
            if element.key == key {
                buckets[index].remove(at: i)
                count -= 1
                return element.value
            }
        }
        
        return nil  // key not in hash table
    }
    
    /// Removes all key-value pairs from the hash table.
    public mutating func removeAll() {
        buckets = Array<Bucket>(repeatElement([], count: initialCapacity))
        count = 0
    }
    
    /// Returns the given key's array index.
    /// - Parameter key: key
    private func index(forKey key: Key) -> Int {
        return abs(key.hashValue % buckets.count)
    }
    
    
    /// Append key-value pair to the hash table.
    /// - Parameters:
    ///   - value: value
    ///   - key: key
    private mutating func addElement(_ value: Value, forKey key: Key) {
        let index = self.index(forKey: key)
        
        buckets[index].append((key: key, value: value))
        count += 1
    }
    
    /*
     Table Doubling
     */
    
    /// If count > Table capacity, increase Table capacity 2x
    private mutating func increaseTableCapacity() {
        let oldBuckets = buckets
        buckets = Array<Bucket>(repeatElement([], count: (oldBuckets.count * 2)))
        count = 0
        oldBuckets.forEach{ bk in
            bk.forEach{ element in
                addElement(element.value, forKey: element.key)
            }
        }
    }
    
    /// If count < Table capacity / 4, shrink Table capacity 1/2
    private mutating func shrinkTableCapacity() {
//        assert(buckets.count > initialCapacity)
        
        let oldBuckets = buckets
        buckets = Array<Bucket>(repeatElement([], count: (oldBuckets.count / 2)))
        count = 0
        oldBuckets.forEach{ bk in
            bk.forEach{ element in
                addElement(element.value, forKey: element.key)
            }
        }
    }
    
    private mutating func doTableDoubling() {
        if count == buckets.count {
            increaseTableCapacity()
        }
        
        if buckets.count > initialCapacity && count == (1 + (buckets.count / 4))  {
            shrinkTableCapacity()
        }
    }
}

extension HashTable: CustomStringConvertible {
    /// A String that represents the contents of the hash table.
    public var description: String {
        let pairs = buckets.flatMap { b in b.map{ e in "\(e.key) = \(e.value)" } }
        return pairs.joined(separator: ", ")
    }
    
    public var debugDescription: String {
        var str = ""
        for (i, bucket) in buckets.enumerated() {
            let pairs = bucket.map{ e in "\(e.key) = \(e.value)" }
            str += "bucket \(i): " + pairs.joined(separator: ", ") + "\n"
        }
        return str
    }
}

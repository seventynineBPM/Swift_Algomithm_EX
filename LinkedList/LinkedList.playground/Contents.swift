/*
 Reference : https://github.com/raywenderlich/swift-algorithm-club
 */
import UIKit

public final class LinkedList<T> {
    
    public class LinkedListNode<T> {
        var value: T
        var next: LinkedListNode?
        weak var previous: LinkedListNode?
        
        public init(_ value: T) {
            self.value = value
        }
    }
    
    public typealias Node = LinkedListNode<T>
    
    private(set) var head: Node?
    
    public var last: Node? {
        guard var node = head else {
            return nil
        }
        
        while let next = node.next  {
            node = next
        }
        
        return node
    }
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var count: Int {
        guard var node = head else {
            return 0
        }
        
        var count = 1
        while let next = node.next {
            node = next
            count +=  1
        }
        
        return count
    }
    
    public init() {}
    
    /// Subscript function to return the node at a specific index
    ///
    /// - Parameter index: Integer value of the requested value's index
    public subscript(index: Int) -> T {
        let node = self.node(at: index)
        return node.value
    }
    
    public func node(at index: Int) -> Node {
        assert(head != nil, "List is empty")
        assert(index >= 0, "index must be greater than 0")
        
        if index == 0 {
            return head!
        } else {
            var node = head!.next
            for _ in 1..<index {
                node = node?.next
                if node == nil {
                    break
                }
            }
            
            assert(node != nil, "index is out of bounds.")
            return node!
        }
    }
    
    public func append(_ value: T) {
        let newNode = Node(value)
        append(newNode)
    }
    
    public func append(_ node: Node) {
        let newNode = node
        if let lastNode = last {
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }
    
    public func append(_ list: LinkedList) {
        var nodeToCopy = list.head
        while let node = nodeToCopy {
            append(node.value)
            nodeToCopy = node.next
        }
    }
    
    public func insert(_ value: T, at index: Int) {
        let newNode = Node(value)
        insert(newNode, at: index)
    }
    
    public func insert(_ newNode: Node, at index: Int) {
        if index == 0 {
            newNode.next = head
            head?.previous = newNode
            head = newNode
        } else {
            let prev = node(at: index - 1)
            let next = prev.next
            newNode.previous = prev
            newNode.next = next
            next?.previous = newNode
            prev.next = newNode
        }
    }
    
    public func insert(_ list:LinkedList, at index: Int) {
        if list.isEmpty { return }
        
        if index == 0 {
            list.last?.next = head
            head = list.head
        } else {
            let prev = node(at: index - 1)
            let next = prev.next
            
            prev.next = list.head
            list.head?.previous = prev
            
            list.last?.next = next
            next?.previous = list.last
        }
    }
    
    func removeAll() {
        head == nil
    }
    
    @discardableResult public func remove(node: Node) -> T {
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        
        next?.previous = prev
        
        node.previous = nil
        node.next = nil
        return node.value
    }
    
    @discardableResult public func removeLast() -> T {
        assert(!isEmpty)
        return remove(node: last!)
    }
    
    @discardableResult public func remove(at index: Int) -> T {
        let node = self.node(at: index)
        return remove(node: node)
    }
}

// MARK: - Extension to enable the standard conversion of a list to String
extension LinkedList: CustomStringConvertible {
    public var description: String {
        var s = "["
        var node = head
        while let nd = node {
            s += "\(nd.value)"
            node = nd.next
            if node != nil { s += ", " }
        }
        return s + "]"
    }
}

// MARK: - Extension to add a 'reverse' to the list
extension LinkedList {
    public func reverse() {
        var node = head
        while let currentNode = node {
            node = currentNode.next
            swap(&currentNode.next, &currentNode.previous)
            head = currentNode
        }
    }
}

// MARK: - An extension with an implementation of 'map' & 'filter' fuctions
extension LinkedList {
    public func map<U>(transform: (T) -> U) -> LinkedList<U> {
        let result = LinkedList<U>()
        var node = head
        while let nd = node {
            result.append(transform(nd.value))
            node = nd.next
        }
        return result
    }
    
    public func filter(predicate: (T) -> Bool) -> LinkedList<T> {
        let result = LinkedList<T>()
        var node = head
        while let nd = node {
            if predicate(nd.value) {
                result.append(nd.value)
            }
            node = nd.next
        }
        return result
    }
}

// MARK: - Extension to enable initialization from an Array
extension LinkedList {
    convenience init(array: Array<T>) {
        self.init()
        
        array.forEach { append($0) }
    }
}

// MARK: - Extension to enable initialization from an Array Literal
extension LinkedList: ExpressibleByArrayLiteral {
    public convenience init(arrayLiteral elements: T...) {
        self.init()
        
        elements.forEach { append($0) }
    }
}

// MARK: - Collection
extension LinkedList: Collection {

    public typealias Index = LinkedListIndex<T>

    /// The position of the first element in a nonempty collection.
    ///
    /// If the collection is empty, `startIndex` is equal to `endIndex`.
    /// - Complexity: O(1)
    public var startIndex: Index {
        get {
            return LinkedListIndex<T>(node: head, tag: 0)
        }
    }

    /// The collection's "past the end" position---that is, the position one
    /// greater than the last valid subscript argument.
    /// - Complexity: O(n), where n is the number of elements in the list. This can be improved by keeping a reference
    ///   to the last node in the collection.
    public var endIndex: Index {
        get {
            if let h = self.head {
                return LinkedListIndex<T>(node: h, tag: count)
            } else {
                return LinkedListIndex<T>(node: nil, tag: startIndex.tag)
            }
        }
    }
    
    public subscript(position: Index) -> T {
        get {
            return position.node!.value
        }
    }
    
    public func index(after idx: Index) -> Index {
        return LinkedListIndex<T>(node: idx.node?.next, tag: idx.tag + 1)
    }
}

// MARK: - Collection Index
/// Custom index type that contains a reference to the node at index 'tag'
public struct LinkedListIndex<T>: Comparable {
    fileprivate let node: LinkedList<T>.LinkedListNode<T>?
    fileprivate let tag: Int
    
    public static func == (lhs: LinkedListIndex<T>, rhs: LinkedListIndex<T>) -> Bool {
        return (lhs.tag == rhs.tag)
    }
    
    public static func < (lhs: LinkedListIndex<T>, rhs: LinkedListIndex<T>) -> Bool {
        return (lhs.tag < rhs.tag)
    }
}


let list = LinkedList<String>()
list.isEmpty
list.head
list.last

list.append("Hello")
list.isEmpty
list.head!.value
list.last!.value
list.count

list.append("world")
list.head!.value
list.last!.value
list.count

list.head!.previous
list.head!.next!.value
list.last!.previous!.value
list.last!.next

list.node(at: 0).value
list.node(at: 1).value

list[0]
list[1]

let list2 = LinkedList<String>()
list2.append("Goodbye")
list2.append("World")
list.append(list2)
list2.removeAll()
list2.isEmpty
list.removeLast()
list.remove(at: 2)

list.insert("Swift", at: 1)
list[0]
list[1]
list[2]
print(list)

list.reverse()

list.node(at: 0).value = "Universe"
list.node(at: 1).value = "Swifty"
let m = list.map { s in s.count }
m
let f = list.filter{ s in s.count > 5 }
f

list.remove(node: list.head!)
list.count
list[0]
list[1]

list.count
list.removeLast()
list.head?.value
list[0]

list.remove(at: 0)
list.count

let list3 = LinkedList<String>()
list3.insert("2", at: 0)
list3.count
list3.insert("4", at: 1)
list3.count
list3.insert("5", at: 2)
list3.count
list3.insert("3", at: 1)
list3.insert("1", at: 0)

let list4 = LinkedList<String>()
list4.insert(list3, at: 0)
list4.count

let list5 = LinkedList<String>()
list5.append("0")
list5.insert("End", at: 1)
list5.count
list5.insert(list4, at: 1)
list5.count

let linkedList: LinkedList<Int> = [1,2,3,4]
linkedList.count
linkedList[0]

let listArrayLiteral2: LinkedList = ["Swift", "Algorithm", "Club"]
listArrayLiteral2.count
listArrayLiteral2[0]
listArrayLiteral2.removeLast()

let collection: LinkedList<Int> = [1,2,3,4,5]
let index2 = collection.index(collection.startIndex, offsetBy: 2)
let value = collection[index2]

var sum = 0
for element in collection {
    sum += element
}
sum

let result = collection.reduce(0) { $0 + $1 }

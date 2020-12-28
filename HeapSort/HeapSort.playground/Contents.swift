/*
Reference : https://github.com/raywenderlich/swift-algorithm-club

 Performance of heap sort is O(n log n) in best, worst, and average case.
*/
import UIKit

extension Heap {
    public mutating func sort() -> [T] {
        for i in stride(from: (nodes.count - 1), through: 1, by: -1) {
            nodes.swapAt(0, i)
            shiftDown(from: 0, until: i)
        }
        return nodes
    }
}

/*
 Sorts an array using a heap.
 Heapsort can be performed in-place, but it is not a stable sort.
 */
public func heapsort<T>(_ a: [T], _ sort: @escaping (T, T) -> Bool) -> [T] {
    let reverseOrder = { i1, i2 in sort(i2, i1) }
    var h = Heap(array: a, sort: reverseOrder)
    return h.sort()
}

var h1 = Heap(array: [5, 13, 2, 25, 7, 17, 20, 8, 4], sort: >)
let a1 = h1.sort()
if a1 != [2, 4, 5, 7, 8, 13, 17, 20, 25] {
    print("testSort 1 - Failed. [5, 13, 2, 25, 7, 17, 20, 8, 4]")
}

var a1_ = heapsort([5, 13, 2, 25, 7, 17, 20, 8, 4], <)
if a1_ != [2, 4, 5, 7, 8, 13, 17, 20, 25] {
    print("testHeapsort 1 - Failed. [5, 13, 2, 25, 7, 17, 20, 8, 4]")
}

var h2 = Heap(array: [16, 14, 10, 8, 7, 8, 3, 2, 4, 1], sort: >)
let a2 = h2.sort()
if a2 != [1, 2, 3, 4, 7, 8, 8, 10, 14, 16] {
    print("testSort 2 - Failed. [16, 14, 10, 8, 7, 8, 3, 2, 4, 1]")
}

let a2_ = heapsort([16, 14, 10, 8, 7, 8, 3, 2, 4, 1], <)
if a2_ != [1, 2, 3, 4, 7, 8, 8, 10, 14, 16] {
    print("testHeapsort 2 - Failed. [16, 14, 10, 8, 7, 8, 3, 2, 4, 1]")
}

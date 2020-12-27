/*
Reference : https://github.com/raywenderlich/swift-algorithm-club

*/

import UIKit

class HeapTests {
    
    fileprivate func verifyMaxHeap(_ h: Heap<Int>) -> Bool {
        for i in 0..<h.count {
            let left = h.leftChildIndex(ofIndex: i)
            let right = h.rightChildIndex(ofIndex: i)
            let parent = h.parentIndex(ofIndex: i)
            if left < h.count && h.nodes[i] < h.nodes[left] { return false }
            if right < h.count && h.nodes[i] < h.nodes[right] { return false }
            if i > 0 && h.nodes[parent] < h.nodes[i] { return false }
        }
        return true
    }
    
    fileprivate func verifyMinHeap(_ h: Heap<Int>) -> Bool {
        for i in 0..<h.count {
            let left = h.leftChildIndex(ofIndex: i)
            let right = h.rightChildIndex(ofIndex: i)
            let parent = h.parentIndex(ofIndex: i)
            if left < h.count && h.nodes[i] > h.nodes[left] { return false }
            if right < h.count && h.nodes[i] > h.nodes[right] { return false }
            if i > 0 && h.nodes[parent] > h.nodes[i] { return false }
        }
        return true
    }
    
    fileprivate func isPermutation(_ array1: [Int], _ array2: [Int]) -> Bool {
        var a1 = array1
        var a2 = array2
        if a1.count != a2.count { return false }
        while a1.count > 0 {
            if let i = a2.firstIndex(of: a1[0]) {
                a1.remove(at: 0)
                a2.remove(at: i)
            } else {
                return false
            }
        }
        return a2.count == 0
    }
    
    func testCreateMaxHeap() {
        let h1 = Heap(array: [1,2,3,4,5,6,7], sort: >)
        print(h1.nodes)
        if verifyMaxHeap(h1) != true {
            print("testCreateMaxHeap h1 - Failed. This is not max heap")
        }
        if verifyMinHeap(h1) != false {
            print("testCreateMaxHeap h1 - Failed. This is min heap")
        }
        if h1.nodes != [7, 5, 6, 4, 2, 1, 3] {
            print("testCreateMaxHeap h1 - Failed. This is not [7, 5, 6, 4, 2, 1, 3]")
        }
        if h1.isEmpty == true {
            print("testCreateMaxHeap h1 - Failed. This is Empty")
        }
        if h1.count != 7 {
            print("testCreateMaxHeap h1 - Failed. This count is not 7")
        }
        if h1.peek() != 7 {
            print("testCreateMaxHeap h1 - Failed. Peek is not 7")
        }
        
        let h2 = Heap(array: [4, 1, 3, 2, 16, 9, 10, 14, 8, 7], sort: >)
        print(h2.nodes)
        if verifyMaxHeap(h2) != true {
            print("testCreateMaxHeap h2 - Failed. This is not max heap")
        }
        if verifyMinHeap(h2) != false {
            print("testCreateMaxHeap h2 - Failed. This is min heap")
        }
        if h2.nodes != [16, 14, 10, 8, 7, 9, 3, 2, 4, 1] {
            print("testCreateMaxHeap h2 - Failed. This is not [16, 14, 10, 8, 7, 9, 3, 2, 4, 1]")
        }
        if h2.isEmpty == true {
            print("testCreateMaxHeap h2 - Failed. This is Empty")
        }
        if h2.count != 10 {
            print("testCreateMaxHeap h2 - Failed. This count is not 10")
        }
        if h2.peek() != 16 {
            print("testCreateMaxHeap h2 - Failed. Peek is not 16")
        }
    }
    
    func testCreateMinHeap() {
        let h1 = Heap(array: [1, 2, 3, 4, 5, 6, 7], sort: <)
        print(h1.nodes)
        if verifyMinHeap(h1) != true {
            print("testCreateMinHeap - Failed. This is not min heap")
        }
        if verifyMaxHeap(h1) != false {
            print("testCreateMinHeap - Failed. This is max heap")
        }
        if h1.nodes != [1, 2, 3, 4, 5, 6, 7] {
            print("testCreateMinHeap - Failed. This is not [1, 2, 3, 4, 5, 6, 7]")
        }
        if h1.isEmpty == true {
            print("testCreateMinHeap - Failed. This is Empty")
        }
        if h1.count != 7 {
            print("testCreateMinHeap - Failed. This count is not 7")
        }
        if h1.peek() != 1 {
            print("testCreateMinHeap - Failed. Peek is not 1")
        }
        
        let h2 = Heap(array: [4, 1, 3, 2, 16, 9, 10, 14, 8, 7], sort: <)
        print(h2.nodes)
        if verifyMinHeap(h2) != true {
            print("testCreateMinHeap - Failed. This is not min heap")
        }
        if verifyMaxHeap(h2) != false {
            print("testCreateMinHeap - Failed. This is max heap")
        }
        if h2.nodes != [1, 2, 3, 4, 7, 9, 10, 14, 8, 16] {
            print("testCreateMinHeap - Failed. This is not [1, 2, 3, 4, 7, 9, 10, 14, 8, 16]")
        }
        if h2.isEmpty == true {
            print("testCreateMinHeap - Failed. This is Empty")
        }
        if h2.count != 10 {
            print("testCreateMinHeap - Failed. This count is not 10")
        }
        if h2.peek() != 1 {
            print("testCreateMinHeap - Failed. Peek is not 1")
        }
    }
}

let heapTest = HeapTests()
heapTest.testCreateMaxHeap()
heapTest.testCreateMinHeap()

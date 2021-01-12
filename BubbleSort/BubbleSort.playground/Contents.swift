/*
 Reference : https://github.com/raywenderlich/swift-algorithm-club
 
 Time : O(n^2)
*/

import UIKit

public func bubbleSort<T> (_ elements: [T]) -> [T] where T: Comparable {
    return bubbleSort(elements, <)
}

public func bubbleSort<T> (_ elements: [T], _ comparision: (T,T) -> Bool) -> [T] {
    var array = elements
    
    for i in 0..<array.count {
        for j in 1..<array.count-i {
            if comparision(array[j], array[j-1]) {
                let tmp = array[j-1]
                array[j-1] = array[j]
                array[j] = tmp
            }
        }
    }
    
    return array
}

var array = [4,2,1,3]

print("before:", array)
print("after: ", bubbleSort(array))
print("after: ", bubbleSort(array, <))
print("after: ", bubbleSort(array, >))

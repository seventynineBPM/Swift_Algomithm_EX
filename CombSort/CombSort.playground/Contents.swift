/*
 Reference : https://github.com/raywenderlich/swift-algorithm-club
 
 Time : O(n^2)
 
 Similar to Bubble Sort, two values within an array are compared. When the lower
 index value is larger than the higher index value, and thus out of place within the
 array, they are swapped. Unlike Bubble Sort, the value being compared against is a
 set distance away. This value -- the gap -- is slowly decreased through iterations.
*/
import UIKit

public func combSort<T: Comparable>(_ input: [T]) -> [T] {
    var copy: [T] = input
    var gap = copy.count
    let shrink = 1.2    // You need to decrease for big size array.
    
    while gap > 1 {
        gap = (Int)(Double(gap) / shrink)
        if gap < 1 {
            gap = 1
        }
        
        var index = 0
        while !(index + gap >= copy.count) {
            if copy[index] > copy[index + gap] {
                copy.swapAt(index, index + gap)
            }
            index += 1
        }
    }
    
    return copy
}

func isASC<T: Comparable>(_ input: [T]) -> Bool {
    for (i, _) in input.enumerated() {
        if i > 0, input[i] < input[i-1] {
            print("i = \(input[i]) , i-1 = \(input[i-1])")
            return false
        }
    }
    
    return true
}

let array = [2, 32, 9, -1, 89, 101, 55, -10, -12, 67]
let sorted = combSort(array)

print("before : ", array)
print("sorted : ", sorted)

var bigArray = [Int](repeating: 0, count: 1000)
var i = 0
while i < 1000 {
    bigArray[i] = Int(arc4random_uniform(1000) + 1)
    i += 1
}
let sortedBigArr = combSort(bigArray)
print("bigArray sorted : ", isASC(sortedBigArr))

//print("before")
//print(bigArray)
//print("after")
//print(sortedBigArr)

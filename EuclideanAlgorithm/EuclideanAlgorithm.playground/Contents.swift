/*
 Euclid's Algorithm
 Given two positive integers m and n, find their greatest common divider,
 that is, the largest positive integer that evenly divides both m and n.
 
 E1. [Find remainder.] Divide m by n and let r be the remainder. (We will evenly 0 ≤ r < n.)
 E2. [Is it zero?] If r = 0, the algorithm terminates; n is the answer.
 E3. [Reduce.] Set m ← n, n ← r, and go back to step E1.
 
 Time : Θ(n) : n is bits of smaller number.
*/
import UIKit

func largestCommonDiviver(_ left: Int, _ right: Int) -> Int {
    if left < 1, right < 1 {
        return 0
    }
    
    let mod = left % right
    
    if mod == 0 {
        return right
    }
    
    return largestCommonDiviver(right, mod)
}

let m = 20
let n = 8

print(largestCommonDiviver(20, 8))
print(largestCommonDiviver(8, 20))

print(largestCommonDiviver(119, 544))



import UIKit

/*
 *  search : O(1.6^n) ~> O(2^n)
 */
class Fibonacci_Recursion {
    
    func find(_ order: Int) -> Int {
        if order == 0 {
            return 0
        }
        if order == 1 {
            return 1
        }
        
        return find(order - 1) + find(order - 2)
    }
}

/*
 *          time    space
 * search : O(n)    O(n)
 */
class Fibonacci_Caching {
    let max_order = 45
    let unknown = -1
    var cach = [Int]()
    
    func find(_ order: Int) -> Int {
        if order > max_order {
            return -1
        }
        
        if order == 0 {
            return 0
        }
        
        if order == 1 {
            return 1
        }
        
        for i in 0...max_order {
            if i == 0 { cach.append(0) }
            else if i == 1 { cach.append(1)}
            else { cach.append(unknown) }
        }
        
        return findCach(order)
    }
    
    private func findCach(_ order: Int) -> Int {
        if cach[order] == unknown {
            cach[order] = findCach(order - 1) + findCach(order - 2)
        }
        
        return cach[order]
    }
}

/*
*          time    space
* search : O(n)    O(n)
*/
class Fibonacci_DP {
    let max_order = 45
    var cach = [Int]()
    
    func find(_ order: Int) -> Int {
        if order > max_order {
            return -1
        }
        
        for i in 0...order {
            if i == 0 { cach.append(0) }
            else if i == 1 { cach.append(1) }
            else { cach.append(cach[i-1] + cach[i-2]) }
        }
        
        return cach[order]
    }
}

//let fibonacciReNum = Fibonacci_Recursion().find(7)
//print(fibonacciReNum)

//let fibonacciCachNum = Fibonacci_Caching().find(7)
//print(fibonacciCachNum)

let fibonacciDPNum = Fibonacci_DP().find(7)
print(fibonacciDPNum)

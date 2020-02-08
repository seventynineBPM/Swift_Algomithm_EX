/*
Reference : https://github.com/raywenderlich/swift-algorithm-club
Rabin-Karp algorithm
*/
import UIKit

struct Constants {
    static let hashMultiplier = 69069
}

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ** : PowerPrecedence

func ** (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}

func ** (radix: Double, power: Int) -> Double {
    return pow(radix, Double(power))
}

extension Character {
    var asInt: Int {
        let s = String(self).unicodeScalars
        return Int(s[s.startIndex].value)
    }
}

/// Find first position of pattern in the text using Rabin Karp algorithm
/// - Parameters:
///   - text: text
///   - pattern: pattern
public func search(text: String, pattern: String) -> Int {
    // convert to array of ints
    let patternArray = pattern.compactMap{ $0.asInt }
    let textArray = text.compactMap{ $0.asInt }
    
    if textArray.count < patternArray.count {
        return -1
    }
    
    let patternHash = hash(array: patternArray)
    var endIdx = patternArray.count - 1
    let firstChars = Array(textArray[0...endIdx])
    let firstHash = hash(array: firstChars)
    
    if patternHash == firstHash {
        // Verify this was not a hash collison
        if firstChars == patternArray {
            return 0
        }
    }
    
    var prevHash = firstHash
    //Now slide the window across the text to be searched
    for idx in 1...(textArray.count - patternArray.count) {
        endIdx = idx + (patternArray.count - 1)
        let window = Array(textArray[idx...endIdx])
        let windowHash = nextHash(prevHash: prevHash, dropped: textArray[idx - 1], added: textArray[endIdx], patternSize: patternArray.count - 1)
        
        if windowHash == patternHash {
            if patternArray == window {
                return idx
            }
        }
        
        prevHash = windowHash
    }
    
    return -1
}

public func hash(array: Array<Int>) -> Double {
    var total: Double = 0
    var exponent = array.count - 1
    for i in array {
        total += Double(i) * (Double(Constants.hashMultiplier) ** exponent)
        exponent -= 1
    }
    
    return Double(total)
}

public func nextHash(prevHash: Double, dropped: Int, added: Int, patternSize: Int) -> Double {
    let oldHash = prevHash - (Double(dropped) * (Double(Constants.hashMultiplier) ** patternSize))
    return Double(Constants.hashMultiplier) * oldHash + Double(added)
}

// TESTS
let result_1 = search(text:"The big dog jumped over the fox", pattern:"ump")
print("result_1 = \(result_1)")
assert(result_1 == 13, "Invalid index returned")

let result_2 = search(text:"The big dog jumped over the fox", pattern:"missed")
print("result_2 = \(result_2)")
assert(result_2 == -1, "Invalid index returned")

let result_3 = search(text:"The big dog jumped over the fox", pattern:"T")
print("result_3 = \(result_3)")
assert(result_3 == 0, "Invalid index returned")


/*
Rabin-Karp algorithm 응용
String.hashCode 사용
*/

class RabinKarp_HashValue {
    var text = ""
    var pattern = ""
    
    init(_ text: String) {
        self.text = text
    }
    
    /// Find first position of pattern in the text
    /// - Parameter pattern: pattern
    func search(_ pattern: String) -> Int {
        if text.count < pattern.count {
            return -1
        }
        
        if text.count == pattern.count {
            if text.hashValue == pattern.hashValue, text == pattern {
                return 0
            }
        }
        
        let patternHashValue = pattern.hashValue
        
        for idx in 1...(text.count - pattern.count) {
            let startIndex = text.index(text.startIndex, offsetBy: idx)
            let endIndex = text.index(startIndex, offsetBy: pattern.count)
            
            let splitText = text[startIndex..<endIndex]
            
            if patternHashValue == splitText.hashValue, pattern == splitText {
                return idx
            }
        }
        
        return -1
    }
}


let keywordSearching = RabinKarp_HashValue("The big dog jumped over the fox")
let keywordIndex_1 = keywordSearching.search("ump")
print("keywordIndex_1 = \(keywordIndex_1)")

let keywordIndex_2 = keywordSearching.search("ver")
print("keywordIndex_2 = \(keywordIndex_2)")

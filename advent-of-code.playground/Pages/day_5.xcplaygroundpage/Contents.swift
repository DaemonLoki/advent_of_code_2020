//: [Previous](@previous)

import Foundation

var content = loadPuzzleInput(day: "5")!

let boardingPasses = content.split(separator: "\n")

assert(boardingPasses.count == 875)

/* Puzzle 1 */
func splitPass(_ pass: String) -> [String] {
    assert(pass.count == 10)
    
    let firstPart = String(pass.prefix(7))
    let secondPart = String(pass.suffix(3))
    
    assert(firstPart.count == 7)
    assert(secondPart.count == 3)
    
    return [firstPart, secondPart]
}

func decipherCode(_ encodedString: String) -> Int {
    let powerOfTwo = encodedString.count - 1
    var startRange = 0
    var endRange = (2 << (powerOfTwo)) - 1
    
    for (index, c) in encodedString.enumerated() {
        if "FL".contains(c) {
            endRange -= Int(round(Double(endRange - startRange) / 2))
        } else if "BR".contains(c) {
            startRange += (2 << (powerOfTwo - index - 1))
        } else {
            fatalError("Not a valid character found!")
        }
    }
    
    assert(startRange == endRange)
    return startRange
}

let ids = boardingPasses
    .map { splitPass(String($0)) }
    .map { (splitStrings: [String]) -> Int in
        let row = decipherCode(splitStrings[0])
        let col = decipherCode(splitStrings[1])
        
        return row * 8 + col
    }

print("Maximum id is \(ids.max() ?? -1)")

/* Puzzle 2 */
func findMyId(in ids: [Int]) -> Int {
    let sortedIds = ids.sorted()
    
    for i in 1 ..< sortedIds.count - 1 {
        // when id before is 2 smaller we found it
        if sortedIds[i - 1] == sortedIds[i] - 2 {
            return sortedIds[i] - 1
        }
    }
    
    return -1
}

print("My id is \(findMyId(in: ids))")

//: [Next](@next)

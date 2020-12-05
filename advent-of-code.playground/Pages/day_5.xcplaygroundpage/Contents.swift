//: [Previous](@previous)

import Foundation

var content = loadPuzzleInput(day: "5")!

let boardingPasses = content.split(separator: "\n")

assert(boardingPasses.count == 875)

func splitPass(_ pass: String) -> [String] {
    assert(pass.count == 10)
    
    let firstPart = String(pass.prefix(7))
    let secondPart = String(pass.suffix(3))
    
    assert(firstPart.count == 7)
    assert(secondPart.count == 3)
    
    return [firstPart, secondPart]
}

func decipherCode(_ encodedString: String) -> Int {
    let powerOfTwo = encodedString.count
    var startRange = 0
    var endRange = (2 << (encodedString.count - 1)) - 1
    
    for (index, c) in encodedString.enumerated() {
        if "FL".contains(c) {
            endRange -= Int(round(Double(endRange - startRange) / 2))
        } else if "BR".contains(c) {
            startRange += (2 << (powerOfTwo - index - 2))
        } else {
            fatalError("Not a valid character found!")
        }
    }
    
    assert(startRange == endRange)
    return startRange
}

let maximumId = boardingPasses
    .map { splitPass(String($0)) }
    .map { (splitStrings: [String]) -> Int in
        let row = decipherCode(splitStrings[0])
        let col = decipherCode(splitStrings[1])
        
        return row * 8 + col
    }
    .max()

print("Maximum id is \(maximumId ?? -1)")

//: [Next](@next)

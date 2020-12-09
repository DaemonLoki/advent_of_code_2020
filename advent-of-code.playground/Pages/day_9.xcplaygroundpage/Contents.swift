//: [Previous](@previous)

import Foundation

let content = loadPuzzleInput(day: "9")!
let testContent = loadPuzzleInput(day: "9_test")!.split(separator: "\n").compactMap { Int($0) }

/* Puzzle 1 */
let numberArray = content.split(separator: "\n").compactMap { Int($0) }

let windowSize = 25
for index in windowSize..<numberArray.count {
    let current = numberArray[index]
    
    var foundCombination = false
    outerLoop: for runner1 in 1...windowSize {
        for runner2 in 2...windowSize {
            if runner1 == runner2 { continue }
            
            if numberArray[index - runner1] + numberArray[index - runner2] == current {
                foundCombination = true
                break outerLoop
            }
        }
    }
    
    if !foundCombination {
        print("The weakness is at \(current)")
        break
    }
}

/* Puzzle 2 */
func searchForWeakness(for number: Int, in numbers: [Int]) -> Int {
    for index in 0..<numbers.count {
        var sum = 0
        var runner = 0
        var min = Int.max
        var max = Int.min
        while sum < number {
            let runningNumber = numbers[index + runner]
            min = runningNumber < min ? runningNumber : min
            max = runningNumber > max ? runningNumber : max
            sum += runningNumber
            if sum == number {
                return min + max
            }
            runner += 1
        }
    }
    
    return -1
}

print("Test data: \(searchForWeakness(for: 127, in: testContent))")
print("Real data: \(searchForWeakness(for: 26134589, in: numberArray))")

//: [Next](@next)

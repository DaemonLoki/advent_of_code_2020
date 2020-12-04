//: [Previous](@previous)

import Foundation

var content = loadPuzzleInput(day: "3")!

var slopes = content.split(separator: "\n").compactMap { Array(String($0)) }

func findNumberOfTrees(on slope: [[String.Element]], rightStep: Int, downwardsStep: Int) -> Int {
    let slopeWidth = slopes[0].count
    let slopeHeight = slopes.count
    
    var currentXPosition = 0
    var currentYPosition = 0
    var treeCount = 0
    
    while currentYPosition < slopeHeight {
        currentXPosition = (currentXPosition + rightStep) % slopeWidth
        currentYPosition += downwardsStep
        if currentYPosition >= slopeHeight { break }
        if String(slopes[currentYPosition][currentXPosition]) == "#" {
            treeCount += 1
        }
        
    }
    return treeCount
}

/* Puzzle 1 */
let rightIncrease = 3
let downIncrease = 1

print("Encountered \(findNumberOfTrees(on: slopes, rightStep: rightIncrease, downwardsStep: downIncrease)) trees.")

/* Puzzle 2 */
let stepTuples = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
let endResult = stepTuples.map { findNumberOfTrees(on: slopes, rightStep: $0.0, downwardsStep: $0.1) }.reduce(1, { $0 * $1 })

print("Product of all trees encountered is \(endResult)")

//: [Next](@next)

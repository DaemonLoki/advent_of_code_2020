//: [Previous](@previous)

import Foundation

var content = loadPuzzleInput(day: "3")!

var slopes = content.split(separator: "\n").compactMap { Array(String($0)) }

let xIncrease = 3
let yIncrease = 1

let endY = slopes.count

var currentXPosition = 0
var currentYPosition = 0
var treeCount = 0
for y in 1 ..< endY {
    currentXPosition += xIncrease
    currentXPosition = currentXPosition % slopes[0].count
    if String(slopes[y][currentXPosition]) == "#" {
        treeCount += 1
    }
}

print("Encountered \(treeCount) trees.")

//: [Next](@next)

//: [Previous](@previous)

import Foundation

/* Puzzle 1 */
struct Bag {
    var color: String
    var count: Int
    var containingBags: [Bag]
}

var content = loadPuzzleInput(day: "7")!

func expressionToBag(_ expression: Substring) -> Bag {
    let count = Int(expression.trimmingCharacters(in: .whitespacesAndNewlines).prefix(1)) ?? 1
    return Bag(color: removeCountFromBag(expression).components(separatedBy: " bag")[0], count: count, containingBags: [])
}

func removeCountFromBag(_ bagWithCount: Substring) -> String {
    let startIndex = bagWithCount.index(bagWithCount.startIndex, offsetBy: 3)
    return String(bagWithCount[startIndex..<bagWithCount.endIndex])
}

func lineToBag(_ line: Substring) -> Bag {
    let lineElements = line.components(separatedBy: "contain")
    let bagColor = lineElements[0].components(separatedBy: " bag")[0]
    
    if lineElements[1].contains("no other bags") {
        return Bag(color: bagColor, count: 1, containingBags: [])
    } else {
        let containingBags: [Bag] = lineElements[1]
            .split(separator: ",")
            .map { expressionToBag($0) }

        return Bag(color: bagColor, count: 1, containingBags: containingBags)
    }
}

var allBags = content.split(separator: "\n")
    .map { lineToBag($0) }
    
let bagToLookFor = "shiny gold"

func isContained(_ bag: Bag, presentInOther bags: [Bag]) -> Bool {
    for otherBag in bags {
        if otherBag.containingBags.contains(where: { $0.color == bag.color }) {
            return true
        }
    }
    
    return false
}

func bagsContaining(_ color: String) -> [Bag] {
    return allBags.filter { $0.containingBags.contains(where: { $0.color == color })}
}

func findBagsRecursively(_ color: String, bagsContainingRoot: Set<String>) -> Set<String> {
    let newBags = bagsContaining(color)
    if newBags.count == 0 {
        return bagsContainingRoot
    }
    
    var newBagsContainingRoot = bagsContainingRoot
    for bag in newBags {
        if newBagsContainingRoot.contains(bag.color) { continue }
        newBagsContainingRoot.insert(bag.color)
        newBagsContainingRoot = newBagsContainingRoot.union(findBagsRecursively(bag.color, bagsContainingRoot: newBagsContainingRoot))
    }
    
    return newBagsContainingRoot
}

print("Found bags: \(findBagsRecursively(bagToLookFor, bagsContainingRoot: []).count)")

/* Puzzle 2 */
func getBag(with color: String) -> Bag? {
    allBags.filter { $0.color == color }.first
}

func crawlBags(_ color: String, count: Int) -> Int {
    guard let currentBag = getBag(with: color) else { return 0 }
    if currentBag.containingBags.count == 0 { return 0 }
    
    var numberOfBags = 0
    
    for bag in currentBag.containingBags {
        numberOfBags += bag.count + (bag.count * crawlBags(bag.color, count: 0))
    }
    
    return numberOfBags
}

print("# of bags contained in \(bagToLookFor) is: \(crawlBags(bagToLookFor, count: 0))")

//: [Next](@next)

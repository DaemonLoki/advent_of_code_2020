//: [Previous](@previous)

import Foundation

let content = loadPuzzleInput(day: "1")!
let numbersArray = content.split(separator: "\n").compactMap { Int($0) }


/* Puzzle 1 */
outerLoop: for i in 0 ..< numbersArray.count - 1 {
    for j in 1 ..< numbersArray.count {
        if numbersArray[i] + numbersArray[j] == 2020 {
            let product = numbersArray[i] * numbersArray[j]
            print("\(numbersArray[i]) and \(numbersArray[j]) add up to 2020 and multiply to \(product).")
            break outerLoop
        }
    }
}

/* Puzzle 2 */
outerLoop: for i in 0 ..< numbersArray.count - 1 {
    for j in 1 ..< numbersArray.count {
        for k in 2 ..< numbersArray.count {
            if numbersArray[i] + numbersArray[j] + numbersArray[k] == 2020 {
                let product = numbersArray[i] * numbersArray[j] * numbersArray[k]
                print("\(numbersArray[i]) and \(numbersArray[j]) and \(numbersArray[k]) add up to 2020 and multiply to \(product).")
                break outerLoop
            }
        }
    }
}


//: [Next](@next)

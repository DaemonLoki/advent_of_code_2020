//: [Previous](@previous)

import Foundation

let content = loadPuzzleInput(day: "6")!

/* Puzzle 1 */
func getAnswers(from input: String) -> [String] {
    return input.components(separatedBy: "\n\n")
}

func preprocess(answer: String) -> String {
    return answer.replacingOccurrences(of: "\n", with: "")
}

func getUniqueAnswers(from answers: String) -> Int {
    return Set(answers).count
}

let sumOfAnswers = getAnswers(from: content)
    .map { preprocess(answer: $0) }
    .map { getUniqueAnswers(from: $0) }
    .reduce(0, { $0 + $1 })

print("The sum of answers is \(sumOfAnswers)")

//: [Next](@next)

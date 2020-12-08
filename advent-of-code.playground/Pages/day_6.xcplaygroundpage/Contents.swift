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

let sumOfUniqueAnswers = getAnswers(from: content)
    .map { preprocess(answer: $0) }
    .map { getUniqueAnswers(from: $0) }
    .reduce(0, { $0 + $1 })

print("The sum of unique answers is \(sumOfUniqueAnswers)")

/* Puzzle 2 */
let uniqueAnswersOverall = Set(content.replacingOccurrences(of: "\n", with: ""))//.map { String($0) })

let sumOfAnswersEveryoneGave = getAnswers(from: content)
    .map {
        $0.split(separator: "\n")
            .map { Set($0) }
            .reduce(uniqueAnswersOverall, { $0.intersection($1) })
            .count
     }
    .reduce(0, +)

print("The sum of answers everyone gave is \(sumOfAnswersEveryoneGave)")

//: [Next](@next)

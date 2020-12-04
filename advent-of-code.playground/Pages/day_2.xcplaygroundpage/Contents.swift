//: [Previous](@previous)

import Foundation

var content = loadPuzzleInput(day: "2")!


func validPassword(_ password: String, char c: Character, in range: ClosedRange<Int>) -> Bool {
    return range.contains(password.reduce(0) { $1 == c ? $0 + 1 : $0 })
}

func convertRange(from rangeString: String) -> ClosedRange<Int> {
    let splitRangeString = rangeString.split(separator: "-").compactMap { Int($0) }
    return splitRangeString[0]...splitRangeString[1]
}

func convertChar(from substring: Substring) -> Character {
    var convertedString = String(substring)
    return convertedString.removeFirst()
}

var validPasswordCount = content.split(separator: "\n").filter { (password) in
    let elements = password.split(separator: " ")
    let range = convertRange(from: String(elements[0]))
    let char = convertChar(from: elements[1])
    let passwordString = String(elements[2])
    return validPassword(passwordString, char: char, in: range)
}.count

print("Found \(validPasswordCount) valid passwords.")

//: [Next](@next)

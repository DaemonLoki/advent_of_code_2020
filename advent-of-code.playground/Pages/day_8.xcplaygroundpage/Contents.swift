//: [Previous](@previous)

import Foundation

/* Puzzle 1 */
let testContent = loadPuzzleInput(day: "8_test")!
let content = loadPuzzleInput(day: "8")!

enum Instruction {
    case nop(Int)
    case acc(Int)
    case jmp(Int)
}

func transformLineToInstruction(_ line: Substring) -> Instruction? {
    let lineElements = line.split(separator: " ")
    guard let instructionValue = Int(lineElements[1]) else { return nil }
    
    switch lineElements[0] {
    case "nop":
        return .nop(instructionValue)
    case "acc":
        return .acc(instructionValue)
    case "jmp":
        return .jmp(instructionValue)
    default:
        return nil
    }
}

//let instructions: [Instruction] = testContent.split(separator: "\n" ).compactMap { transformLineToInstruction($0) }
let instructions: [Instruction] = content.split(separator: "\n" ).compactMap { transformLineToInstruction($0) }

var changedLines = Set<Int>()

func run(_ instructions: [Instruction], allowChanges: Bool = false) -> (Int, Bool) {
    var accumulatedValue = 0
    var lineOfCurrentInstruction = 0
    var visitedInstructions: Set<Int> = []
    var cleanRun = false
    var valueChanged = false
    var mutableInstructions = instructions
    
    while !visitedInstructions.contains(lineOfCurrentInstruction) {
        visitedInstructions.insert(lineOfCurrentInstruction)
        
        let currentInstruction = mutableInstructions[lineOfCurrentInstruction]
        
        switch currentInstruction {
        case .nop(let value):
            if allowChanges && !valueChanged && !changedLines.contains(lineOfCurrentInstruction) {
                valueChanged = true
                changedLines.insert(lineOfCurrentInstruction)
                mutableInstructions[lineOfCurrentInstruction] = .jmp(value)
                lineOfCurrentInstruction += value
            } else {
                lineOfCurrentInstruction += 1
            }
        case .acc(let value):
            accumulatedValue += value
            lineOfCurrentInstruction += 1
        case .jmp(let goalLine):
            if allowChanges && !valueChanged && !changedLines.contains(lineOfCurrentInstruction) {
                valueChanged = true
                changedLines.insert(lineOfCurrentInstruction)
                mutableInstructions[lineOfCurrentInstruction] = .nop(goalLine)
                lineOfCurrentInstruction += 1
            } else {
                lineOfCurrentInstruction += goalLine
            }
        }
                
        if lineOfCurrentInstruction >= instructions.count {
            cleanRun = true
            break
        }
    }
    
    return (accumulatedValue, cleanRun)
}

let result = run(instructions)
print("Accumulator value is \(result.0)")


/* Puzzle 2 */
print("Trying to fix it...")
for _ in 0..<instructions.count {
    let runResult = run(instructions, allowChanges: true)
    if runResult.1 == true {
        print("Accumulator value is \(runResult.0)")
        break
    }
}

//: [Next](@next)

import Foundation

public func loadPuzzleInput(day: String) -> String? {
    guard let puzzleUrl = Bundle.main.url(forResource: "puzzle_\(day)", withExtension: "txt") else { return nil }

    guard let content = try? String(contentsOf: puzzleUrl, encoding: .utf8) else { return nil }
    
    return content
}
